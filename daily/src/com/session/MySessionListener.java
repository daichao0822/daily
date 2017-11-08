package com.session;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/*通过HttpSessionListener监听来管理我自己的SessionContext*/

public class MySessionListener implements HttpSessionListener {
	public void sessionCreated(HttpSessionEvent httpSessionEvent) {
	    MySessionContext.AddSession(httpSessionEvent.getSession());
	    }
	    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
	        HttpSession session = httpSessionEvent.getSession();
	        MySessionContext.DelSession(session);
	    }

}
