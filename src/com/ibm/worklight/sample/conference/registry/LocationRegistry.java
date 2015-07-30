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

package com.ibm.worklight.sample.conference.registry;

import java.util.HashMap;
import java.util.SortedSet;
import java.util.TreeSet;

import com.ibm.worklight.sample.conference.beans.Location;

public class LocationRegistry extends HashMap<String, Location> {

	private static final long serialVersionUID = 1L;
	private HashMap<String,SortedSet<String>> locationList = new HashMap<String,SortedSet<String>>();
	
	@Override
	public Location put(String id, Location location) {
		SortedSet<String> set=null;
		if(id.startsWith("usa")){
			if(locationList.containsKey("usa")){
				set = locationList.get("usa");
				set.add(id);
			}else{
				set = new TreeSet<String>();
				locationList.put("usa", set);
			}
		}else{
			if(locationList.containsKey("worldtrade")){
				set = locationList.get("worldtrade");
				set.add(id);
			}else{
				set = new TreeSet<String>();
				locationList.put("worldtrade", set);
			}
		}
		set.add(id);
		System.out.println("set ->" + set);
		return super.put(id, location);
	}

	public HashMap<String, SortedSet<String>> getLocationList() {
		System.out.println("locationList ->" + locationList);
		
		return locationList;
	}
	

}
