<%@page import="com.google.appengine.api.channel.ChannelServiceFactory"%>
<%@page import="com.google.appengine.api.channel.ChannelService"%>
<%@page import="java.util.Random"%>
<%@page import="org.krzysio.games.filters.UsernameCookieFilter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="jsp/headerSection.jsp"></jsp:include>

<%
	String clientID = "CL_ID_" + System.currentTimeMillis() + "_" + Math.abs(new Random().nextInt());
	ChannelService channelService = ChannelServiceFactory.getChannelService();
	String channelToken = channelService.createChannel(clientID);

	String username = (String) request.getAttribute(UsernameCookieFilter.USERNAME_COOKIE);
	
	pageContext.setAttribute("clientID", clientID);
	pageContext.setAttribute("username", username);
	pageContext.setAttribute("channelToken", channelToken);
%>

</head>
<body>
	<jsp:include page="jsp/errWarnPanels.jsp">
		<jsp:param value="${username}" name="username"/>
	</jsp:include>
	
	<jsp:include page="jsp/chatPage.jsp"></jsp:include>
</body>
</html>