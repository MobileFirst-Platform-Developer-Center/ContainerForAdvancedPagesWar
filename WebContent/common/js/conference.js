/**
* Copyright 2015 IBM Corp.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
 
var isEOCOpen = false;

function __openEOC(callback) {
	var mykey = "abc";

	if (isEOCOpen) {
		if (callback) {
			callback();
		}
		return;
	} 
	WL.EncryptedCache.open(mykey, true, function() {
		isEOCOpen = true;
		if (callback) {
			callback();
		}
	}, function(err) {
		alert('Failed to open encrypted cache ' + err);
	});
}

function __writeEOC(mykey, mydata, callback) {
	WL.EncryptedCache.write(mykey, mydata, function() {
		callback();
	}, function() {
		alert('An error occurred writing to the encrypted cache');
	});
}

function __removeEOC(mykey, callback){
	WL.EncryptedCache.remove(mykey, function(){
		if(callback){
			callback();
		}
	},
	function() {
		alert('An error occured removing favorite from cache');
	}
	);
}

function __readEOC(mykey, callback) {

	WL.EncryptedCache.read(mykey, function(data) {
		/* alert('eoc read success ' + data); */
		if (callback) {
			callback(data);
		}
	}, function() {
		alert('Failed to read from the encrypted cache');
	});
}

function saveToCache(key, value) {

	if (isEOCOpen == false) {
		__openEOC(function() {
			__writeEOC(key, value, function() {
			});
		});
	} else {
		__writeEOC(key, value, function() {
		}, function() {
			alert('Unable to write to encrypted cache');
		});
	}
}

function removeFromCache(key) {

	if (isEOCOpen == false) {
		__openEOC(function() {
			__removeEOC(key, function() {
			});
		});
	} else {
		__removeEOC(key, function() {
		}, function() {
			alert('Unable to remove item from the encrypted cache');
		});
	}
}


//function saveUserPw() {
//	var c = dojo.byId('saveCreds');
//	if (c.checked) {
//		var userField = document.getElementById('username');
//		var user = userField.value;
//		var passField = document.getElementById('password');
//		var pass = passField.value;
//
//		/* alert("trying to save user/pass " + user + "/" + pass); */
//		if (isEOCOpen == false) {
//			__openEOC(function() {
//				__writeEOC("user", user, function() {
//					__writeEOC("pass", pass, reallySubmitForm);
//				});
//			});
//		} else {
//			__writeEOC("user", user, function() {
//				__writeEOC("pass", pass, reallySubmitForm);
//			});
//		}
//	} else {
//		reallySubmitForm();
//	}
//}

//function processForm() {
//	saveUserPw();
//	if (e.preventDefault) {
//		e.preventDefault();
//	}
//	return false;
//}
//
//function reallySubmitForm() {
//	document.getElementById('loginForm').submit();
//}
//
//function updateFieldsFromCache() {
//
//	if (isEOCOpen == false) {
//		__openEOC(function() {
//			__readEOC("user", function(username) {
//				var uField = document.getElementById('username');
//				uField.value = username;
//				__readEOC("pass", function(password) {
//					document.getElementById('password').value = password;
//				});
//			});
//		});
//	} else {
//		__readEOC("user", function(username) {
//			var uField = document.getElementById('username');
//			uField.value = username;
//			__readEOC("pass", function(password) {
//				document.getElementById('password').value = password;
//			});
//		});
//	}
//}

/** push stuff * */
WL.Client.Push.onReadyToSubscribe = function() {
	alert("onReadyToSubscribe");

	WL.Client.Push.registerEventSourceCallback("myPush",
			"ConferencePushNotification", "ConferenceEventSource",
			pushNotificationReceived);
};

// --------------------------------- Subscribe
// ------------------------------------
function subscribeButtonClicked() {
	WL.Client.Push.registerEventSourceCallback("myPush",
			"ConferencePushNotification", "ConferenceEventSource",
			pushNotificationReceived);

	WL.Client.Push.subscribe("myPush", {
		onSuccess : pushSubscribe_Callback,
		onFailure : pushSubscribe_Callback
	});
}

function pushSubscribe_Callback(response) {
	alert("PushSubscribe_Callback invoked");
}

function pushNotificationReceived(props, payload) {
	alert("pushNotificationReceived invoked");
	alert("props :: " + payload.txt);
	// alert("payload :: " + Object.toJSON(payload));
}

function checkForFav(details) {
	if (isEOCOpen == false) {
		__openEOC(function() {
			__readEOC(details, function(value) {
				if(value === 'fav'){
					dijit.byId(details).set('on');
				}
			});
		});
	} else {
		__readEOC(details, function(value) {
			if(value === 'fav'){
				dijit.byId(details).set('value', 'on');
			}
		});
	}
}

function updateFav(details) {

	var isChecked = dijit.byId(details).get('value');
	if(isChecked){
		//WL.EnvProfile.initialize();
		saveToCache(details, 'fav');
	}else{
		removeFromCache(details);
	}
	
}
