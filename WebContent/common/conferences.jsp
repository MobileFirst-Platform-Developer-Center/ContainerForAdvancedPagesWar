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
