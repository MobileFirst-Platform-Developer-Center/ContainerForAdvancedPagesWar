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

package com.ibm.worklight.sample.conference;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.ibm.worklight.sample.conference.beans.Conference;
import com.ibm.worklight.sample.conference.beans.Location;
import com.ibm.worklight.sample.conference.beans.Presenter;
import com.ibm.worklight.sample.conference.beans.Session;
import com.ibm.worklight.sample.conference.registry.LocationRegistry;

@WebListener()
public class ConferenceListener implements ServletContextListener {
	
	public void contextInitialized (ServletContextEvent sce) {
		sce.getServletContext().log("context initialized");
	
		LocationRegistry registry = createLocationRegistry();
		ServletContext context = sce.getServletContext();
		context.setAttribute("locationRegistry", registry);
		context.setAttribute("locationRegistryList", registry.getLocationList());
		sce.getServletContext().log("location registry ->" + context.getAttribute("locationRegistry"));
	}

	public void contextDestroyed(ServletContextEvent sce) {
		sce.getServletContext().log("contextDestroyed(ServletContextEvent e)");
    }

	
	public static LocationRegistry createLocationRegistry(){
		LocationRegistry registry = new LocationRegistry();

		
		{
			Location loc = new Location ("usa_dc", "Washington", "DC", "USA");
			loc.addConference(createWebSphereConference());
			loc.addConference(createMobileFirstConference() );
			registry.put(loc.getId(),loc);
		}
		
		{
		
			Location  loc = new Location ( "usa_ma", "Boston", "MA", "USA");
			loc.addConference(createMobileFirstConference() );
			loc.addConference(createMobileConference());
			registry.put(loc.getId(),loc);

		}
		
		{
			Location loc = new Location ( "usa_ca", "San Francisco", "CA", "USA");
			loc.addConference(createMobileFirstConference() );
			registry.put(loc.getId(),loc);
		}
		
		{
			Location loc = new Location ("usa_tx", "Austin", "TX", "USA");
			loc.addConference(createMobileFirstConference() );
			loc.addConference(createMobileConference());
			
			registry.put(loc.getId(), loc);
		}
		
		{
			Location loc = new Location ("usa_fl", "Miami", "FL", "USA");
			loc.addConference(createWebSphereConference());
			loc.addConference(createMobileConference());
			loc.addConference(createMobileFirstConference() );
			registry.put(loc.getId(), loc);
		}
		
		{
			Location loc = new Location ("china_bj", "Beijing", "", "China");
			loc.addConference(createMobileFirstConference() );
			loc.addConference(createMobileConference());
			
			registry.put(loc.getId(), loc);
		}
		
		{
			Location loc = new Location ("china_sh", "Shanghai", "", "China");
			loc.addConference(createMobileFirstConference() );
			loc.addConference(createMobileConference());
			
			registry.put(loc.getId(), loc);
		}

		{
			Location loc = new Location ("france_paris", "Paris", "", "France");
			loc.addConference(createMobileFirstConference() );
			loc.addConference(createMobileConference());
			
			registry.put(loc.getId(), loc);
		}
		{
			Location loc = new Location ( "eng_lon", "London", "CA", "England");
			loc.addConference(createMobileFirstConference() );
			registry.put(loc.getId(),loc);
		}

		
		
		return registry;
		
	}
	
	
	private static Date getAfterDate(Date date, int days) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR)
				+ days);
		//return df.format(calendar.getTime());
		return calendar.getTime();
	}
	
	private static Date getAfterTime(Date date, int hours) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY)
				+ hours+1);
		
		calendar.set(Calendar.MINUTE, 00);
		return calendar.getTime();
		//return df.format(calendar.getTime());
	}
	
	private static Conference createWebSphereConference(){
		java.util.Date now = new java.util.Date();
		
		java.util.Date conferenceDate = getAfterDate(now, 1);
		
		Conference conference = new Conference("was", "IBM WebSphere Conference", conferenceDate );
		
		Session session = new Session("WAS400", "Hadoop for Enterprise Applications", getAfterTime(conferenceDate, 1), getAfterTime(conferenceDate, 3), "Raleigh B305");
		Presenter presenter = new Presenter ("bob", "Bob", "Peterson", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		presenter = new Presenter ("john", "John", "Black", "Technical Sales");
		session.addPresenter(presenter);
		conference.addSession(session);
		
		session = new Session("WAS500", "Migrating Existing Web Applications to Mobile",getAfterTime(conferenceDate, 3), getAfterTime(conferenceDate, 5),"Austin B785");
		presenter = new Presenter ("tina", "Tina", "Wong", "Serviceability Lead");
		session.addPresenter(presenter);
		conference.addSession(session);
		
		return conference;
	}
	
	private static Conference createMobileFirstConference(){
		java.util.Date now = new java.util.Date();
		
		java.util.Date conferenceDate = getAfterDate(now, 7);
		
		
		Conference 	conference = new Conference("iwl", "IBM MobileFirst Conference",conferenceDate);

		Session session = new Session("IWL345", "Migrating Existing Web Applications to Mobile", getAfterTime(conferenceDate, 2), getAfterTime(conferenceDate, 4),"San Jose C222");
		conference.addSession(session);
		Presenter presenter = new Presenter ("mary", "Mary", "Smith", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		presenter = new Presenter ("john", "John", "Doe", "Advisory Software Engineer");
		session.addPresenter(presenter);
		
		
		session = new Session("IWL567", "IBM MobileFirst Security", getAfterTime(conferenceDate, 4), getAfterTime(conferenceDate, 6),"Boulder C454");
		conference.addSession(session);
		presenter = new Presenter ("john", "John", "Doe", "Advisory Software Engineer");
		session.addPresenter(presenter);
		
		
		session = new Session("IWL364", "Connecting to the Enterprise with MobileFirt Platform Adapters", getAfterTime(conferenceDate, 6), getAfterTime(conferenceDate, 8), "Rochester C203");
		presenter = new Presenter ("mary", "Mary", "Smith", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		conference.addSession(session);
		
		session = new Session("IWL368", "Connecting to the Enterprise with MobileFirst Platform Adapters", getAfterTime(conferenceDate, 6), getAfterTime(conferenceDate, 8), "Rochester C203");
		presenter = new Presenter ("mary", "Mary", "Smith", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		conference.addSession(session);
		
		session = new Session("IWL369", "Connecting to the Enterprise with MobileFirst Platform Adapters", getAfterTime(conferenceDate, 6), getAfterTime(conferenceDate, 8), "Rochester C203");
		presenter = new Presenter ("mary", "Mary", "Smith", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		conference.addSession(session);

		return conference;
	}
	
	private static Conference createMobileConference(){
		java.util.Date now = new java.util.Date();
		
		java.util.Date conferenceDate = getAfterDate(now, 7);
		
		
		Conference conference = new Conference("mc", "Mobile Conference", conferenceDate);

		Session session = new Session("MOB586", "Migrating Existing Web Applications to Mobile", getAfterTime(conferenceDate, 3), getAfterTime(conferenceDate, 5),"Hursley D222");
		conference.addSession(session);
		Presenter presenter = new Presenter ("mary", "Mary", "Smith", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		presenter = new Presenter ("john", "John", "Doe", "Advisory Software Engineer");
		session.addPresenter(presenter);
		
		
		session = new Session("MOB234", "Enterprise Mobile Architecture and Design", getAfterTime(conferenceDate, 5), getAfterTime(conferenceDate, 7),"Bangalore D674");
		conference.addSession(session);
		presenter = new Presenter ("john", "John", "Doe", "Advisory Software Engineer");
		session.addPresenter(presenter);
		
		
		session = new Session("MOB90", "Practicing Agile Development", getAfterTime(conferenceDate, 7), getAfterTime(conferenceDate, 9),"Gentilly D723");
		presenter = new Presenter ("mary", "Mary", "Smith", "Senior Technical Staff Member");
		session.addPresenter(presenter);
		conference.addSession(session);

		
		return conference;
		
		
	}
	
}
