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

package com.ibm.worklight.sample.conference.beans;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class Conference{
	
	private DateFormat df = DateFormat.getDateInstance(DateFormat.FULL);

	
	private String id;
	private String name;
	private Date date;
	

	private List<Session> sessions = new ArrayList<Session>();
	
	public Conference(String id, String name, Date date) {
		super();
		
		this.id = id;
		this.name = name;
		this.date = date;
	}
	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}
	public String getDate() {
		return df.format(date);
	}
	
	public void addSession (Session session){
		this.sessions.add(session);
	}
	

	public List<Session> getSessions() {
		return sessions;
	}

}
