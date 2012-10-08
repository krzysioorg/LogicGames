<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	//ChannelServiceFactory.getChannelService();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="jsp/headerSection.jsp"></jsp:include>
</head>

<body>
	<jsp:include page="errWarnPanels.jsp">
		<jsp:param value="${username}" name="username" />
	</jsp:include>

	<h1>Welcome to Smart Games site!</h1>
	<br id="brTag_for0">

	<p>
	<textarea id="mainChat" name="mainChat" rows="15" cols="80"
			style="width: 60%" class="tinymce" placeholder="Enter message text">
	</textarea>
	<input type="button" value="Send"
		onclick="sendMsgToChat('', 'mainChat');">

<script type="text/javascript" language="javascript">
	var username = '${username}';
	var channel = new goog.appengine.Channel('${channelToken}');
	var socket;

	function initSocket() {
		socket = channel.open();
		socket.onopen = onOpened;
		socket.onmessage = onMessage;
		socket.onerror = function(errObj) {
			showErrPanelWithTimeout(errObj.code + ": "
					+ errObj.description, 20000);
		};
		socket.onclose = showWarnPanel("WebSocket connection lost.");
	}

	initSocket();
</script>
</body>
</html>