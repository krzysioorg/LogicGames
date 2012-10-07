var tabsConfig = new Array();
var warnPanelTimeoutHandler;
var errPanelTimeoutHandler;

function showNotification(msg) {
	// TODO - provide real info panel
	showWarnPanelWithTimeout(msg, 5000);
}

function showWarnPanel(warnMsg) {
	$("#warnPanelInfo").html(warnMsg);
	$("#warnPanel").show(500);
}

function hideWarnPanel() {
	$("#warnPanelInfo").html("");
	$("#warnPanel").hide(500);
}

function showErrPanel(errMsg) {
	$("#errPanelInfo").html(errMsg);
	$("#errPanel").show(500);
}

function hideErrPanel() {
	$("#errPanelInfo").html("");
	$("#errPanel").hide(500);
}

function showWarnPanelWithTimeout(warnMsg, timeout) {
	showWarnPanel(warnMsg);
	if (timeout > 0) {
		clearTimeout(warnPanelTimeoutHandler);
		warnPanelTimeoutHandler = setTimeout("hideWarnPanel();", timeout);
	}
}

function showErrPanelWithTimeout(warnMsg, timeout) {
	showErrPanel(warnMsg);
	if (timeout > 0) {
		clearTimeout(errPanelTimeoutHandler);
		errPanelTimeoutHandler = setTimeout("hideErrPanel();", timeout);
	}
}

function byName(nodeName) {
	return $("[name = '" + nodeName + "']");
}

function byId(nodeId) {
	return $("#" + nodeId);
}

function sendMsgToChat(chatId, inputId) {
	var html = byId(inputId).html();
	
	$.ajax({
		url: 'ajaxHandler',
		type: 'POST',
		data: { action     : 'sendMsgToChat',
				'chatId'   : chatId,
				'html'     : html
			},
		complete: function(resp, textStatus) {
			if (textStatus == "success") {
				var result = $.parseJSON(resp.responseText);
				switch (result.status) {
					case 'OK':
						byId(inputId).val("");
						break;
					default:
						showErrPanelWithTimeout("There was an error. We are already working on it.", 10000);
				}
			} else {
				showWarnPanelWithTimeout("Connection error. Try again later.", 10000);
			}
		}
	});
}

function handleIncomingMsg(data) {
	var chatId = data.chatId;
	var brTag = byId("brTag_for" + chatId);
	
	var html = '<div class="ui-widget" chatId="${chatId}">' +
					'<div class="ui-crner-all" style="margin-top: 20px; padding: 0 .7em;">' +
						'<p>' + 
						'<span class="ui-icon ui-icon-comment" style="float: left; margin-right: .3em;"></span>' +
						'<span class="htmlToReplace">' +
							'<strong>${item[0]}</strong>&nbsp; &nbsp; ${item[1]}' +
							'<span>${item[2]}</span>' +
							'</span>' +
					'</div>' +
				'</div>';
				
	html = html.replace("${item[0]}", data.sender);
	html = html.replace("${item[1]}", data.date);
	html = html.replace("${item[2]}", data.htmlMessage);
	
	brTag.before(html);
	
	// ponizsze musialem zastapic powyzszym, bo mi jQuery.tabs sie wymadrzal 
	// i zmienial uklad DOM wewnatrz zwracanego html-a!
	
//	var htmlToReplace = "<strong>" + data.sender + "</strong>&nbsp; " + data.date +"<br>" + data.htmlMessage;
//	var lastNode = $("[chatId='" + data.chatId + "']").last();
//	var newNode = lastNode.clone(true);
//	$(newNode).find(".htmlToReplace").html(htmlToReplace);
//	lastNode.after(newNode);
}
