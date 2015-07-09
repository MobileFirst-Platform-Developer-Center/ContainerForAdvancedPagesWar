/*
 *
    COPYRIGHT LICENSE: This information contains sample code provided in source code form. You may copy, modify, and distribute
    these sample programs in any form without payment to IBM® for the purposes of developing, using, marketing or distributing
    application programs conforming to the application programming interface for the operating platform for which the sample code is written.
    Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES,
    EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY,
    FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT,
    INDIRECT, INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR OPERATION OF THE SAMPLE SOURCE CODE.
    IBM HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE SOURCE CODE.

 */

define([
	"dojo/_base/kernel",
	"dojo/_base/lang",
	"dojo/_base/declare",
	"dojo/_base/window",
	"dojo/on"
], function(dojo, lang, declare, win, on){

	
var database = {};
var gDB = null;  //global database handle
	

database.fields = {
	'photos' : ["data","type","comment"],
};

/**
 * Error handler
 *
 * @param error
 */
function basicTxnErrorDB(error) {
    alert('Database error: '+error.message+' (Code '+error.code+')');
}

/**
 * Results handler
 *
 * @param trnsaction
 * @param results
 */
function basicTxnSuccessDB(transaction, results) {
    console.log("successful DB transaction");
}

/**
 * Drop database table
 *
 * @param tableName
 */
database.dropTable = function(tableName){
    gDB.transaction(
					function(transaction){
					transaction.executeSql('DROP TABLE ' + tableName, [], basicTxnSuccessDB, basicTxnErrorDB);
					}
					);
};

/**
 * Create database tables if they don't already exist
 */
database.createTables = function(){
	var deferred = new dojo.Deferred();

	var numFinished = 0;
	function finished(){
		numFinished++;
		if(numFinished == 1){
			deferred.resolve();
		}
	}
	
    gDB.transaction(
					function(transaction){
					transaction.executeSql('CREATE TABLE IF NOT EXISTS photos(' +
										   'id INTEGER PRIMARY KEY AUTOINCREMENT,' +
										   'data TEXT,' +
										   'type TEXT,' +
										   'comment TEXT);',
										   [], finished, function(){/* error Handler*/ return false;}
										   );
					},basicTxnErrorDB, basicTxnSuccessDB);
	return deferred;
};

/**
 * Open database for application
 */
database.init = function(){
    console.log("getDatabase()");
    if (!gDB) {
        try {
            if (!window.openDatabase) {
                alert('Local data storage not supported');
            }
            else {
                var shortName = 'conferenceDB';
                var version = '1.0';
                var displayName = 'conference Database';
                var maxSize = 4000000; //65536; // in bytes
                gDB = openDatabase(shortName, version, displayName, maxSize);
                if (!gDB) {
                    console.log("Error opening database: returned null.");
                    return;
                }
                return database.createTables();
            }
        }
        catch (e) {
            if (e == 2) {
                // Version number mismatch.
                console.log("Invalid database version.");
            }
            else {
                console.log("Database error: " + e);
            }
			
        }
    }
};

/**
 * Load object data from database
 *
 * @param name		database to use
 * @param callback	callback for loaded objects
 * @param selector	qualifier for loaded objects
 */
database.load = function(name, callback, selector){	
	console.log("Loading from " + name);
	onLoad = function(transaction, results){
		if(!results.rows.length || results.rows.length == 0){
			callback(null);
			return;
		}
		
		var fields = database.fields[name];
		var obj = [];
		for(var i = 0; i < results.rows.length; i++){
			var row = results.rows.item(i);
			obj[i] = {'id' : row.id};
			for(var j = 0; j < fields.length; j++){
				obj[i][fields[j]] = row[fields[j]];
			}
		}
		
		callback(obj);
	};
	if (selector) 
		selector=' WHERE ' + selector;
	else
		selector='';
	gDB.transaction(function(transaction){
					transaction.executeSql('SELECT * FROM '+name+ selector + ';',
										   [], onLoad,
										   function(transaction, error){ console.log("loading error."); return false;}
										   );
					},basicTxnErrorDB, basicTxnSuccessDB);
	
};

/**
 * Get the next primary key from database
 *
 * @param name		database to use
 * @param callback	callback for key
 */
database.getNextKey = function(name, callback){
	//find the next id used
	gDB.transaction(function(transaction){
					transaction.executeSql('SELECT * FROM sqlite_sequence WHERE name="' + name + '"',
										   [],
										   function(transaction, results){
										   if(results.rows.length == 0){
											   // assume the first autogen # is 1 -- this may need to be revisited
											   callback(1);
										   return;
										   }
										   var key = results.rows.item(0).seq + 1;
										   callback(key);
										   },
										   function(){ console.log(" - error finding next primary key"); return false;}
										   );
					}, basicTxnErrorDB, basicTxnSuccessDB);
};

/**
 * Save object data to database
 *
 * @param obj		object to save
 * @param name		database to use
 * @param callback	optional callback for primary key
 */
database.store = function(obj, name, idCallback){
    // needs error handling!
	var fields = database.fields[name];
	
    var values = new Array(fields.length);
    for (var i=0; i<fields.length; i++){
        values[i] = obj[fields[i]];
    }
	
    var list = fields.join('","');;
    var data = values.join('","');
	
	console.log(list);
	console.log(data);
	
	if (!obj.id || obj.id === "") {
		if(idCallback){
			database.getNextKey(name, idCallback);
		}
		
		gDB.transaction(function(transaction){
						transaction.executeSql('INSERT INTO ' + name + ' ("' + list + '") VALUES ("' + data + '");',
											   [],
											   function(transaction, error){},
											   function(transaction, error){ /* error handler  - not fatal*/ console.log("error storing " + name);console.log(error); return false;}
											   );
						}, basicTxnErrorDB, basicTxnSuccessDB);
	}else{
		list+='","id';
		data+='","' + obj.id;
		gDB.transaction(function(transaction){
						transaction.executeSql('INSERT OR REPLACE INTO ' + name + ' ("' + list + '") VALUES ("' + data + '");',
											   [],
											   function(transaction, error){},
											   function(){ /* error handler  - not fatal*/console.log("error storing " + name); return false;}
											   );
						}, basicTxnErrorDB, basicTxnSuccessDB);
	}
};

/**
 * Load key/value data from database
 *
 * @param name			database to use
 * @param callback		callback for loaded object
 */
database.loadSingle = function(name, callback){
	onLoad = function(transaction, results){
		if(results.rows.length == 0){
			callback(null);
			return;
		}
		
		var obj = {};
		for (var i=0; i<results.rows.length; i++) {
			var row = results.rows.item(i);
			var key = row['key'];
			var value = row['value'];
			obj[key] = value;
		}
		callback(obj);
	};
	
	gDB.transaction(
					function(transaction) {
					var sql = 'SELECT * FROM ' + name + ';';
					transaction.executeSql(sql, [],
										   onLoad, 
										   function(transaction, results)
										   { 
										   console.log("Error loading");
										   }
										   );
					},
					basicTxnErrorDB,
					basicTxnSuccessDB
					);
};

/**
 * Save key/value data to database
 *
 * @param obj		object to save
 * @param name		database to use
 */
database.storeSingle = function(obj, name){
	console.log("storing " + name);
	console.log(obj);
	
	var fields = database.fields[name];
    gDB.transaction(
					function(transaction) {
					for (var i=0; i<fields.length; i++) {
					var key = fields[i];
					var value = (obj[key]) ? obj[key] : "";
					
					var sql = 'INSERT OR REPLACE INTO ' + name + ' (key,value) VALUES ("'+key+'","'+value+'");';
					transaction.executeSql(sql, [],
										   function() { },
										   function() { console.log("Error executing: "+sql); }
										   );
					}
					},
					basicTxnErrorDB,
					basicTxnSuccessDB
					);
};

/**
 * Get photo from database
 *
 * @param index			The photo id
 * @param callback		callback for loaded photo
 */
database.loadPhoto = function(id, callback) {
	database.load('photos', 
		function(obj){
		  if(obj == null || obj.length == 0){
			  callback(null);
		  }else{
			  callback(obj[0]);
		  }
		}, 
		'id=' + id);
	return;
};

/**
 * Get all photo from database
 *
 * @param callback		callback for loaded photo
 */
database.loadAllPhoto = function(callback) {
	database.load('photos',callback);
	return;
};

/**
 * Save photo to database
 *
 * @param index			The photo id
 * @param imageData     The photo data
 * @param type			The type of the photo (1-4)
 * @param comment		The comment of the photo	
 * @param idCallback		callback for the associated id
 */
database.storePhoto = function(id, imageData,type,comment,idCallback) {
	console.log("Storing to " + id);
    var photo = {
		'id' : id,
		'data' : imageData,
		'type' : type,
		'comment' : comment
	};
	database.store(photo, 'photos',idCallback);
};


/**
 * Get photo from database
 *
 * @param index         The photo id
 */
database.getPhoto = function(id,callback) {
    console.log("getPhoto("+id+")");
	database.load('photos', 
		function(obj){
		  if(obj && obj.length > 0){
			if(callback)
			  callback(id, obj[0].data);
		  }else{
			console.log("photo ("+id+") does not exist in the db");
		  }
		}, 
		'id=' + id);
};

/**
 * Delete photo from database
 *
 * @param index         The photo id
 */
database.deletePhoto = function(id) {
	console.log("deletePhoto(" + id + ")");
	gDB.transaction(function(transaction){
					transaction.executeSql('DELETE FROM photos WHERE id='+id,
										   [],
										   function(){ console.log(" - success deleting from photos");},
										   function(){ console.log(" - error deleting from photos"); return false;}
										   );
					}, basicTxnErrorDB, basicTxnSuccessDB);
};

	window.database=database;
	
	return database;
});