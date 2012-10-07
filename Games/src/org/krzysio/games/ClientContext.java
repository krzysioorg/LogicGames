package org.krzysio.games;

import java.io.Serializable;

/**
 * @author krzysztof
 */
public class ClientContext implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public static final String SESSION_KEY = "CLIENTCONTEXT";

	private String username;
	
	public ClientContext() {
	}

	public ClientContext(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	
	
}
