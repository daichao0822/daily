package com.session;

import java.util.HashMap;

import javax.servlet.http.HttpSession;
/*因servlet2.1以后不再支持SessionContext的getSession()方法，
 *无法通过sessionID获取指定session对象，所以自行创建一个SessionContext
 */
public class MySessionContext {
	private static HashMap mymap = new HashMap();
    public static synchronized void AddSession(HttpSession session) {
        if (session != null) {
            mymap.put(session.getId(), session);
        }
    }
    public static synchronized void DelSession(HttpSession session) {
        if (session != null) {
            mymap.remove(session.getId());
        }
    }
    public static synchronized HttpSession getSession(String session_id) {
        if (session_id == null) 
        return null;
        return (HttpSession)mymap.get(session_id);
    }

}
