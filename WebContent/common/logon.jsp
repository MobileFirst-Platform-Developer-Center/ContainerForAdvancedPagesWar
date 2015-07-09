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
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="iOSClient" scope="page" value="${header['user-agent']}"/>

<html>
<head>
<title>Conference Home</title>
<meta http-equiv="Expires" CONTENT="0">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

<link rel="shortcut icon" href="images/icon.png" />
<link rel="apple-touch-icon" href="images/apple-touch-icon.png" />
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

<link rel="stylesheet" href="css/jsp2mobile.css" />
</head>

<body id="content">
	<div dojoType="dojox.mobile.View">
		<c:set var="conferences" scope="session"
			value=""></c:set>
		<!-- a sample heading -->
		<h1 style="text-align: center;" dojoType="dojox.mobile.Heading">IBM Mobile Conference App</h1>
		<form action="j_security_check" method="post" name="loginForm">
			<div class="logonClass">
				<div>
					<span>Username </span> <input id="username" dojoType="dojox.mobile.TextBox"
						name="j_username" />
				</div>
				<div>
					<span>Password </span> <input id="password" type=password name="j_password"
						dojoType="dojox.mobile.TextBox"> </input>

				</div>
				<div style="text-align: center;">
					<input id="login" type="submit" class="mblButton" value="Login"/>
				</div>
			</div>
		</form>
	</div>

	<script type="text/javascript" src="dojo/dojo.js"
		djConfig="parseOnLoad:false"></script>
	<script type="text/javascript">
		window.onload = function() {
			require([ "dojo/dom","dojox/mobile", "dojox/mobile/parser","dijit/registry",
					"dojox/mobile/TextBox", "dojox/mobile/View",
					"dojox/mobile/Heading", "dojox/mobile/Button",
					"dojo/domReady!" ], function(dom, mobile, parser,registry) {
				parser.parse();
			});
		};
	</script>
</body>
</html>