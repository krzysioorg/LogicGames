package org.krzysio.games;

import java.io.Serializable;

/**
 * @author krzysztof
 * 
 */
public class ChannelInfo implements Serializable {

	private static final long serialVersionUID = 1L;

	private String clientID;
	private String token;

	public String getClientID() {
		return clientID;
	}

	public void setClientID(String clientID) {
		this.clientID = clientID;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}
	
}
