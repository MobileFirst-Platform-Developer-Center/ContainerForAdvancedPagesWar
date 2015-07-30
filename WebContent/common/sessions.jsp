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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div dojoType="dojox.mobile.View">
	<c:set var="locationId" value="${param.locationId }"></c:set>
	<c:set var="conferenceId" value="${param.conferenceId }"></c:set>

	<c:set var="location" value="${locationMap[locationId]}"></c:set>
	<c:set var="conference" value="${location.conferences[conferenceId]}"></c:set>
	<div class="list-category" dojoType="dojox.mobile.RoundRectCategory">${conference.name} (${location.city})</div>

	<c:forEach var="session" items="${locationMap[locationId].conferences[conferenceId].sessions}" varStatus="status">
		<div class="list-category" dojoType="dojox.mobile.RoundRectCategory">${session.sessionStart} ${session.sessionStartLong}</div>
		<ul dojoType="dojox.mobile.RoundRectList">
			<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight" url="./sessionDetails.jsp?locationId=${locationId}&conferenceId=${conferenceId}&sessionId=${status.count-1}"  urlTarget="presenters" clickable="true" transition="slide">
					<div class="list-detail">${session.name}</div>
					<div class="list-detail">${session.sessionStart} - ${session.sessionEnd}, ${session.room}</div>
					<div >Favorite <input id="${session.uuid}" preventTouch='true' type='checkbox'
							dojoType="dojox.mobile.CheckBox"
							onclick="updateFav('${session.uuid}')"/></div>
			</li>
		</ul>
	</c:forEach>

</div>
