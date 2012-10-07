package org.krzysio.games.filters;

import java.io.IOException;
import java.util.Random;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.krzysio.games.WebSocketManager;

import com.google.appengine.api.channel.ChannelService;
import com.google.appengine.api.channel.ChannelServiceFactory;

/**
 * @author krzysztof
 *
 */
public class BeforeIndexFilter extends HttpServletFilter {
	
	public static final String CHANNEL_TOKEN = "channelToken";

	@Override
	protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		String clientID = "CL_ID_" + System.currentTimeMillis() + "_" + Math.abs(new Random().nextInt());
		ChannelService channelService = ChannelServiceFactory.getChannelService();
		String channelToken = channelService.createChannel(clientID);
		
		WebSocketManager.getInstance().addChannelInfo(clientID, channelToken);
		
		request.setAttribute(CHANNEL_TOKEN, channelToken);
		response.addCookie(new Cookie("clientID", clientID));
		chain.doFilter(request, response);
	}

}
