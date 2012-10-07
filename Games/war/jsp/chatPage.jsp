<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//ChannelServiceFactory.getChannelService();
%>

<h1>Welcome to Smart Games site!</h1>

<textarea id="mainChat" name="mainChat" rows="15" cols="80" style="width: 60%" 
			class="tinymce" placeholder="Enter message text">
</textarea>
<input type="button" value="Send" onclick="sendMsgToChat('', 'mainChat');">