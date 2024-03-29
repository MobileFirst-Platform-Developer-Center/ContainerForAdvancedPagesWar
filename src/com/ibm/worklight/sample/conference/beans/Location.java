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

import java.util.List;
import java.util.ArrayList;


public class Location {
	private String id;
	private String city;
	private String state;
	private String country;
	private List<Conference> conferences = new ArrayList<Conference>();
	
	public Location(String id, String city, String state, String country) {
		super();
		this.id = id;
		this.city = city;
		this.state = state;
		this.country = country;
	}

	public String getId() {
		return id;
	}

	public String getCity() {
		return city;
	}

	public String getState() {
		return state;
	}

	public String getCountry() {
		return country;
	}
	
	public void addConference (Conference conference){
		this.conferences.add(conference);
	}

	public List<Conference> getConferences() {
		return conferences;
	}
	



}
