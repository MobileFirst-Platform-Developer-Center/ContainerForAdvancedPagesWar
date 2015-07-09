/*
 *
    COPYRIGHT LICENSE: This information contains sample code provided in source code form. You may copy, modify, and distribute
    these sample programs in any form without payment to IBM® for the purposes of developing, using, marketing or distributing
    application programs conforming to the application programming interface for the operating platform for which the sample code is written.
    Notwithstanding anything to the contrary, IBM PROVIDES THE SAMPLE SOURCE CODE ON AN "AS IS" BASIS AND IBM DISCLAIMS ALL WARRANTIES,
    EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, ANY IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY,
    FITNESS FOR A PARTICULAR PURPOSE, TITLE, AND ANY WARRANTY OR CONDITION OF NON-INFRINGEMENT. IBM SHALL NOT BE LIABLE FOR ANY DIRECT,
    INDIRECT, INCIDENTAL, SPECIAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR OPERATION OF THE SAMPLE SOURCE CODE.
    IBM HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS OR MODIFICATIONS TO THE SAMPLE SOURCE CODE.

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
