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
