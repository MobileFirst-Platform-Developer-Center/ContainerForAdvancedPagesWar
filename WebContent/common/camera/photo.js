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

define(["dojo/_base/kernel","dojo/has","dojo/on","dojo/dom"], 
		function(dojo,has,on,dom){
		
	var photo = dojo.getObject("camera.photo",true);

	/**
	 * Take photo
	 *
	 * @param id        The photo id
	 */
	photo.takePhoto = function(obj) {
		if(navigator.camera){
			navigator.camera.getPicture(photoSuccess, photoError, {
				quality : 20,
				destinationType : Camera.DestinationType.DATA_URL
			});
		}else{
			alert("Camera is not supported...");
		}
	};

	/**
	 * Callback for successful photo taken
	 *
	 * @param imageData
	 */
	function photoSuccess(imageData) {
		console.log("photoSuccess() for photo " );
		var p2s = dom.byId('photo2save');
		dojo.empty(p2s);
		p2s.innerHTML='<img style="height:120px" src="data:image/jpeg;base64,'+imageData+'">';
		dojo.query('#photo2save img').forEach(function(imgNode) {
			if (imgNode.src.indexOf("thumbnail") != -1) {
				imgNode.src = "data:image/jpeg;base64," + imageData;
				imgNode.style.height = "120px";
			}
		});
		photo.savePhoto();
	};

	/**
	 * Save photo to local storage
	 *
	 */
	photo.savePhoto = function(){
		console.log("Saving photo to local storage");
		var photo={};
		dojo.query('#photo2save img').forEach(function(imgNode){
			photo.data=imgNode.src;
		});
		if(!photo.data||photo.data===''){
			 navigator.notification.alert('Please take a photo.');
		}
		dojo.query('#photo_dialog select').forEach(function(node){
			photo.type=node.value;
		});
		dojo.query('#photo_dialog textarea').forEach(function(node){
			photo.comment=node.value;
		});
		console.log(photo);
		database.storePhoto('',photo.data,photo.type,photo.comment,function(id){
			photo.id=id;
			displayPhoto(photo);
			require(["dojox/mobile/TransitionEvent"],function(TransitionEvent){
				new TransitionEvent(document.body,{moveTo:"photoGallery",transition:"slide",transitionDir: "1"}).dispatch();
			});
			//dijit.byId('photo_dialog').hide(true);
		});
		
	};

	var phototypes=[""];

	/**
	 * Display photo
	 *
	 * @param photo the photo object 
	 */
	function displayPhoto(photo) {
		console.log("Displaying photo");
		var imageData=photo.data;
		var id=photo.id?photo.id:0;
		var type=photo.type?photo.type:0;
		var comment=photo.comment||'';
		var list=dijit.byId("pList");
		var listitem=new dojox.mobile.ListItem({icon:'images/delete.png',label:'<div>'
							+phototypes[type]+'</div><div class="imagebox"><img src="'+imageData
						    +'">'+comment+'<div class="c"></div></div>',variableHeight:true,clickable:true});
		
		list.addChild(listitem);
		var icon = dojo.query('.mblListItemIcon',listitem.domNode);
		on(icon, "click",function(e){
			e.stopPropagation();
			if(navigator.notification && navigator.notification.confirm){
				navigator.notification.confirm("Do you want to delete the photo?",function(buttonIndex){
					if(buttonIndex==2){
						database.deletePhoto(id);
						dojo.destroy(listitem.domNode);
					}
				},"Delete the Photo", "Cancel, Delete");
			}else{
				var deletePhoteable = confirm("Delete the Photo");
				if(deletePhoteable){
					database.deletePhoto(id);
					dojo.destroy(listitem.domNode);
				}
			}
		});
	}


	/**
	 * Callback for camera error
	 *
	 * @param error
	 */
	function photoError(error) {
		console.log("photoError() for photo : " + error);
	};

	function loadPhotos(){
		database.loadAllPhoto(function(photos){
			console.log(photos);
			if(photos){
				for(var i=0; i< photos.length; i++){
					var photo=photos[i];
					displayPhoto(photo);
				}
			}
		});
	}
	
	function init(){
		console.log("Initialize photo");
		database.init();
		var defer = database.createTables();
		defer.then(loadPhotos());
	}

	return {init:init};
});