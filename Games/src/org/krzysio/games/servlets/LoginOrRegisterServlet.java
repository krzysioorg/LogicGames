package org.krzysio.games.servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;

/**
 * @author kbarczynski
 */
public class LoginOrRegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private static byte[] SALT = "chfbcUYTzdgneessssffffAAADDDdd987@#$$%MD887".getBytes();
	
	private static Logger logger = Logger.getLogger(LoginOrRegisterServlet.class.getName());

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
		String continuePage;
		
		if (isNewUser(request)) {
			continuePage = createNewUser(request);
		} else {
			continuePage = loginUser(request);
		}
		
		getServletContext().getRequestDispatcher(continuePage).forward(request, resp);
	}
	
	private boolean isNewUser(HttpServletRequest request) {
		String newUser = request.getParameter("newUser");
		if (newUser == null) {
			return false;
		}
		
		return newUser.equalsIgnoreCase("on");
	}

	private String createNewUser(HttpServletRequest request) {
		String username = request.getParameter("username");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Entity user = findUser(datastore, username);
		
		if (user != null) {
			request.setAttribute("ERR_MSG", "Entered Username is not allowed");
			return "/login.jsp";
		}
		
		String pass = request.getParameter("pass");
		String confpass = request.getParameter("confpass");
		
		if (StringUtils.isBlank(pass) || !pass.equalsIgnoreCase(confpass)) {
			request.setAttribute("ERR_MSG", "Incorrect password");
			request.setAttribute("username_bak", username);
			return "/login.jsp";
		}
		
		user = new Entity("User");
		user.setProperty("pass", generatePassHash(pass));
		
		
		return "/jsp/chatPage.jsp";
	}
	
	private String loginUser(HttpServletRequest request) {
		return "/login.jsp";
	}
	
	private Entity findUser(DatastoreService datastore, String username) {
		Filter usernameFilter = new Query.FilterPredicate("username", FilterOperator.EQUAL, username);

		Query query = new Query("User").setFilter(usernameFilter);
		return datastore.prepare(query).asSingleEntity();
	}
	
	private String generatePassHash(String pass) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA1");
			md.update(SALT);
			md.update(pass.getBytes());
			
			return md.toString();
		} catch (NoSuchAlgorithmException e) {
			logger.log(Level.WARNING, "Can't generate password hash", e);
			return "";
		}
	}
	
}
