<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="jsp/headerSection.jsp"></jsp:include>

</head>
<body>
	<jsp:include page="jsp/errWarnPanels.jsp">
		<jsp:param value="Tempor_anonymous" name="username"/>
	</jsp:include>
	
	<jsp:include page="jsp/chatPage.jsp"></jsp:include>
</body>
</html>