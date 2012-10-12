<%@page import="org.krzysio.games.ClientContext"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="org.krzysio.games.WebSocketManager"%>
<%@page import="com.google.appengine.api.channel.ChannelServiceFactory"%>
<%@page import="com.google.appengine.api.channel.ChannelService"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="jsp/headerSection.jsp"></jsp:include>

<%
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
%>

</head>

<body>
	<jsp:include page="jsp/errWarnPanels.jsp">
		Conflict change
		<jsp:param value="${username}" name="username"/>
	</jsp:include>
	
	<jsp:include page="jsp/chatPage.jsp"></jsp:include>
	
	<script type="text/javascript" language="javascript">
	var username = '${username}';
	var channel = new goog.appengine.Channel('${channelToken}');
	var socket;

	function initSocket() {
		socket = channel.open();
		socket.onopen = onOpened;
		socket.onmessage = onMessage;
		socket.onerror = function(errObj) {
				showErrPanelWithTimeout(errObj.code + ": " + errObj.description, 20000);
			};
		socket.onclose = showWarnPanel("WebSocket connection lost.");
	}
	
	initSocket();
	</script>
</body>
</html>
