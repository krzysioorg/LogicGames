package org.krzysio.games;

import java.util.HashMap;
import java.util.Map;

/**
 * @author krzysztof
 */
public class WebSocketManager {

	private static final WebSocketManager INSTANCE = new WebSocketManager();
	
	/**
	 * {clientID, ChannelInfo} pairs
	 */
	private final Map<String, ChannelInfo> CHANNELS = new HashMap<String, ChannelInfo>();

	private WebSocketManager() {
	}

	public static WebSocketManager getInstance() {
		return INSTANCE;
	}
	
	public ChannelInfo addChannelInfo(String clientID, String token) {
		ChannelInfo channelInfo = new ChannelInfo();
		channelInfo.setClientID(clientID);
		channelInfo.setToken(token);
		
		CHANNELS.put(clientID, channelInfo);
		
		return channelInfo;
	}
}
