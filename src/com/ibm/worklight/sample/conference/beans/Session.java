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
import java.util.UUID;


public class Session {
	private DateFormat dfShort = DateFormat.getTimeInstance(DateFormat.SHORT);
	private DateFormat dfLong = DateFormat.getDateInstance(DateFormat.FULL);

	
	private String id;
	private String name;
	private Date sessionStart;
	private Date sessionEnd;
	private String room;
	private String uuid;
	private List<Presenter> presenters = new ArrayList<Presenter>();

	
	public Session(String id, String name, Date sessionStart, Date sessionEnd,
			String room) {
		super();
		this.id = id;
		this.name = name;
		this.sessionStart = sessionStart;
		this.sessionEnd = sessionEnd;
		this.room = room;
		this.uuid = UUID.randomUUID().toString();
	}

	public String getId() {
		return id;
	}
	public String getName() {
		return name;
	}

	public String getSessionStartLong() {
		return dfLong.format(sessionStart);
	}

	
	public String getSessionStart() {
		return dfShort.format(sessionStart);
	}

	public String getSessionEnd() {
		return dfShort.format(sessionEnd);
	}

	public String getRoom(){
		return room;
	}
	
	public void addPresenter (Presenter presenter){
		this.presenters.add(presenter);
	}

	public List<Presenter> getPresenters() {
		return presenters;
	}

	public String getUuid(){
		return uuid;
	}
}
