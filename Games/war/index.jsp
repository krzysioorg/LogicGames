<%@page import="org.krzysio.games.ClientContext"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.krzysio.games.WebSocketManager"%>
<%@page import="com.google.appengine.api.channel.ChannelServiceFactory"%>
<%@page import="com.google.appengine.api.channel.ChannelService"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	ClientContext clientContext = (ClientContext) session.getAttribute(ClientContext.SESSION_KEY);
	
	if (clientContext != null) {
		// TODO
	}
	
	/*
	String clientID = "CL_ID_" + System.currentTimeMillis() + "_" + Math.abs(new Random().nextInt());
	ChannelService channelService = ChannelServiceFactory.getChannelService();
	String channelToken = channelService.createChannel(clientID);
	
	String username = (String) request.getSession().getAttribute("username");
	if (StringUtils.isEmpty(username)) {
		username = "Anonymous";
	}
	
	request.getSession().setAttribute(ClientContext.SESSION_KEY, new ClientContext(username));
	
	WebSocketManager.getInstance().addChannelInfo(clientID, channelToken);
	
	pageContext.setAttribute("username", username);
	pageContext.setAttribute("channelToken", channelToken);
	*/
%>

<c:if test="true">
	<jsp:include page="login.jsp"></jsp:include>
</c:if>
