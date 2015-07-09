<%--
    COPYRIGHT LICENSE: This information contains sample code provided in source code form. You may copy, modify, and distribute
    these sample programs in any form without payment to IBM® for the purposes of developing, using, marketing or distributing
    application programs conforming to the application programming interface for the operating platform for which the sample code is written.
    Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES,
    EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY,
    FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT,
    INDIRECT, INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR OPERATION OF THE SAMPLE SOURCE CODE.
    IBM HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE SOURCE CODE.



--%>
<!DOCTYPE html>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="iOSClient" scope="page" value="${header['user-agent']}" />
<html>
<head>
<title>Conference Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style"
	content="black-translucent" />

<link rel="shortcut icon" href="images/icon.png" />
<link rel="apple-touch-icon" href="images/apple-touch-icon.png" />

<link rel="stylesheet" type="text/css"
	href="dojox/mobile/themes/common/mobileListData.css"></link>
<link rel="stylesheet" href="css/reset.css" />
<link rel="stylesheet" href="css/jsp2mobile.css" />
<c:choose>
	<c:when test="${fn:contains(iOSClient, 'Android')}">
		<link rel="stylesheet" type="text/css"
			href="dojox/mobile/themes/android/android.css"></link>
	</c:when>
	<c:otherwise>
		<link rel="stylesheet" type="text/css"
			href="dojox/mobile/themes/iphone/iphone.css"></link>
	</c:otherwise>
</c:choose>
</head>

<body id="content" onload="WL.Client.init({onSuccess:function success(){ console.info('WL init success...'); }, connectOnStartup:false});">
	<c:set var="locationMap" value='${applicationScope.locationRegistry}' scope="session"/>
	<div id="locations" dojoType="dojox.mobile.ScrollableView" selected="true">
	  	<h1 dojoType="dojox.mobile.Heading" label="Locations" fixed="top"></h1>
		<div class="list-category" dojoType="dojox.mobile.RoundRectCategory">USA</div>
		<ul dojoType="dojox.mobile.RoundRectList">
			<c:forEach var="location" items="${applicationScope.locationRegistryList['usa']}">
				<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight"
					url="./conferences.jsp?locationId=${location}"
					urlTarget="conferences" transition="slide">
					<div class="list-detail">
						<div>${locationMap[location].city}, ${locationMap[location].state}</div>
					</div>
				</li>
			</c:forEach>
		</ul>

		<div class="list-category" dojoType="dojox.mobile.RoundRectCategory">International</div>
		<ul dojoType="dojox.mobile.RoundRectList">
			<c:forEach var="location" items="${applicationScope.locationRegistryList['worldtrade']}">
				<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight"
					url="./conferences.jsp?locationId=${location}"
					urlTarget="conferences" transition="slide">
					<div class="list-detail">
						<div>${locationMap[location].city}, ${locationMap[location].country}</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
	
	<div id="conferences" dojoType="dojox.mobile.ScrollableView">
		<h1 dojoType="dojox.mobile.Heading" back="Locations" moveTo="locations" transition="slide" fixed="top">
		 Conferences</h1>
	</div>
	<div id="sessions" dojoType="dojox.mobile.ScrollableView">
		<h1 dojoType="dojox.mobile.Heading" back="Conferences" moveTo="conferences" fixed="top" transition="slide">Sessions </h1>
	</div>
	<div id="presenters" dojoType="dojox.mobile.ScrollableView">
		<h1 dojoType="dojox.mobile.Heading" back="Sessions"
		moveTo="sessions" transition="slide" label="Details" fixed="top">
		<div data-dojo-type="dojox.mobile.ToolBarButton"
			onclick="camera.photo.takePhoto(this);" label="Take Photo"
			style="float: right;"></div>
	    </h1>
	</div>
	<div id="photoGallery" dojoType="dojox.mobile.ScrollableView">
		<h1 dojoType="dojox.mobile.Heading" back="Details" moveTo="presenters"
			transition="slide" label="Photo Gallery"></h1>
		<ul id="pList" dojoType="dojox.mobile.RoundRectList">
		</ul>
	</div>
	
	<h1 id="footbar" data-dojo-type="dojox.mobile.Heading" fixed="bottom">
		<div id="uploadButton"
			style="position: relative; float: right; visibility: hidden;">
			<div data-dojo-type="dojox.mobile.ToolBarButton"
				data-dojo-props='label:"Save Photo to gallery", onClick:
					function(e){
					  camera.photo.savePhoto();
			          return true; 
			        }'></div>
		</div>
		<div style="position: relative; float: left;">
			<form method="post" action="conferenceLogout.jsp" name="logout">
				<span data-dojo-type="dojox.mobile.ToolBarButton"
					data-dojo-props='onClick:function(){
			                                  document.forms["logout"].submit();
		                                        
                         },
                         transition:"slide"'>Logout</span>
				<input type="hidden" name="logoutExitPage" value="/">
			</form>
		</div>
	</h1>


<c:choose>
	<c:when test="${fn:contains(iOSClient, 'Android')}">
	
	
	<script>
		// Define WL namespace.
		var WL = WL ? WL : {};
		/**
		 * WLClient configuration variables.
		 * Values are injected by the deployer that packs the gadget.
		 */
		 WL.StaticAppProps = {
   "APP_DISPLAY_NAME": "AdvancedPages",
   "APP_ID": "AdvancedPages",
   "APP_SERVICES_URL": "\/apps\/services\/",
   "APP_VERSION": "1.0",
   "ENVIRONMENT": "android",
   "LOGIN_DISPLAY_TYPE": "embedded",
   "WORKLIGHT_NATIVE_VERSION": "3826723549",
   "WORKLIGHT_PLATFORM_VERSION": "6.3.0.0",
   "WORKLIGHT_ROOT_URL": "\/apps\/services\/api\/AdvancedPages\/android\/"
};
</script>
		<script src="../mfp_android/ibm/cordova.js"></script>
		<script src="../mfp_android/ibm/wljq.js"></script>
		<script src="../mfp_android/ibm/worklight.js"></script>
		<script src="../mfp_android/ibm/checksum.js"></script>
		<script>window.$ = window.jQuery = WLJQ;</script>
	
	
	
	
	</c:when>
	<c:otherwise>
	
	 <script>
		// Define WL namespace.
		var WL = WL ? WL : {};
		/**
		 * WLClient configuration variables.
		 * Values are injected by the deployer that packs the gadget.
		 */
		 WL.StaticAppProps = {
   "APP_DISPLAY_NAME": "AdvancedPages",
   "APP_ID": "AdvancedPages",
   "APP_SERVICES_URL": "\/apps\/services\/",
   "APP_VERSION": "1.0",
   "ENVIRONMENT": "iphone",
   "LOGIN_DISPLAY_TYPE": "embedded",
   "WORKLIGHT_NATIVE_VERSION": "270878231",
   "WORKLIGHT_PLATFORM_VERSION": "6.3.0.0",
   "WORKLIGHT_ROOT_URL": "\/apps\/services\/api\/AdvancedPages\/iphone\/"
};
</script>
		<script src="../mfp_ios/ibm/cordova.js"></script>
		<script src="../mfp_ios/ibm/wljq.js"></script>
		<script src="../mfp_ios/ibm/worklight.js"></script>
		<script src="../mfp_ios/ibm/checksum.js"></script>
		<script>window.$ = window.jQuery = WLJQ;</script>
		

	</c:otherwise>	
</c:choose>

<script type="text/javascript" src="dojo/dojo.js"
	djConfig="parseOnLoad:false,modulePaths:{'storage': '../js/storage'}"></script>

<script type="text/javascript">
	require([  "dojo/ready","dojox/mobile", "dojox/mobile/parser", "storage",
				"dijit/registry", "dojo/query", "camera/photo",
				"dojox/mobile/View", "dojox/mobile/ScrollableView",
				"dojox/mobile/Heading", "dojox/mobile/Button",
				"dojox/mobile/ToolBarButton",
				"dojox/mobile/RoundRectCategory",
				"dojox/mobile/RoundRectList",
				"dojo/data/ItemFileReadStore", "dojo/domReady!" ],
			function(ready, mobile, parser, database, registry, query, photo) {
				function success(){
					console.info('WL init success...');
				}
				
				function failure(){
					console.info('WL init failure...');
				}
		
				ready(function(){
					parser.parse();
					photo.init();
					
					var presentersView = registry.byId("presenters");
					dojo.connect(presentersView, "onBeforeTransitionIn", null,
							function(moveto, dir, transition, context,
									method) {
								query("#uploadButton").style("visibility",
										"visible");
							});
					dojo.connect(presentersView, "onBeforeTransitionOut", null,
							function(moveto, dir, transition, context,
									method) {
								query("#uploadButton").style("visibility",
										"hidden");
							});
				});
					
	});
</script>

<script src="js/conference.js"></script>
</body>
</html>