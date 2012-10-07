<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div style="position: fixed; top: 5; right: 200; z-index: 10;">
<div id="warnPanel" class="ui-widget" style="display: none;" 
	align="center" onclick="hideWarnPanel();">
	<div class="ui-state-highlight ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
		<span id="warnPanelInfo"><strong>Hey!</strong> Sample ui-state-highlight style.</span></p>
	</div>
</div>
</div>
<br/>
<div style="position: fixed; top: 5; left: 200; z-index: 10;">
<div id="errPanel" class="ui-widget" style="display: none;" 
	align="center" onclick="hideErrPanel();">
	<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
		<p><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
		<span id="errPanelInfo"><strong>Hey!</strong> Sample ui-state-highlight style.</span></p>
	</div>
</div>
</div>

<section id="content">
	<div align="right"><h3><c:out value="${param.username}"/></h3></div>
</section>