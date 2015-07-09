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
