<%--
Copyright 2015 IBM Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
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
