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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:set var="locationId" value="${param.locationId }"></c:set>
<c:set var="conferenceId" value="${param.conferenceId }"></c:set>
<c:set var="sessionId" value="${param.sessionId }"></c:set>
<c:set var="location" value="${locationMap[locationId]}"></c:set>
<c:set var="conference" value="${location.conferences[conferenceId]}"></c:set>


<div dojoType="dojox.mobile.View">

	<div class="list-category" dojoType="dojox.mobile.RoundRectCategory">${conference.name} (${location.city})</div>
	<ul dojoType="dojox.mobile.RoundRectList">
		<c:set var="sessionDetail" value="${locationMap[locationId].conferences[conferenceId].sessions[sessionId]}"></c:set>
	
		<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight">
			<div class="session-name-header">${sessionDetail.name}</div>
		</li>
	
	
		<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight">
			<div class="session-detail-header">Date</div><div class="session-detail-data">${sessionDetail.sessionStartLong}</div>
			
		</li>
		<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight">
			<div class="session-detail-header">Time</div><div  class="session-detail-data">${sessionDetail.sessionStart} - ${sessionDetail.sessionEnd}</div>
		</li>
		<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight">
			<div class="session-detail-header">Room</div><div  class="session-detail-data">${sessionDetail.room}</div>
		</li>

		<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight">
			<div class="session-detail-header">Session ID</div><div  class="session-detail-data">${sessionDetail.id}</div>
		</li>
	
	
		<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight">
			<div class="list-category">Speakers</div>
			<c:forEach var="presenter" items="${sessionDetail.presenters}" varStatus="status">
			
				<div class="list-detail">
				    <div>${presenter.firstName} ${presenter.lastName}, ${presenter.title}</div>
				</div>
				
			</c:forEach>
			</li>
		<li dojoType="dojox.mobile.ListItem" clickable="true"
			moveTo="photoGallery" class="mblVariableHeight" rightText="conference photos" rightIcon="images/icon.png">
			<div id="photo2save">
				<img src="./images/thumbnail.png"/>
			</div>
		</li>
	</ul>
</div>