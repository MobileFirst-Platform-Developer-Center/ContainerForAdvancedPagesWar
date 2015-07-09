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
    <div class="list-category" dojoType="dojox.mobile.RoundRectCategory">${locationMap[param.locationId].city}</div>
	<ul dojoType="dojox.mobile.RoundRectList">
		<c:set var="conferences" value="${locationMap[param.locationId].conferences}" scope="request"></c:set>
		<c:forEach var="conf" items="${conferences}" varStatus="status">
			<li dojoType="dojox.mobile.ListItem" class="mblVariableHeight" url="./sessions.jsp?locationId=${param.locationId}&conferenceId=${status.count-1}"  urlTarget="sessions" clickable="true" transition="slide">
					<div class="list-header">${conf.name}</div>
					<div class="list-detail">${conf.date}</div>
			</li>
		</c:forEach>
	</ul>
</div>
