<%@ Page language="c#" Codebehind="Decorator.aspx.cs" AutoEventWireup="false" Inherits="ThoughtWorks.CruiseControl.WebDashboard.Decorator" %>
<%@ Register Namespace="SiteMesh.DecoratorControls" TagPrefix="decorator" Assembly="Sitemesh" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://localhost/NUnitAsp/dtd/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>
			<decorator:title runat="server" defaulttitle="CruiseControl.Net Build Results" ID="Title1" /></title>
		<meta name="vs_showGrid" content="True">
		<link type="text/css" rel="stylesheet" href="cruisecontrol.css">
	</HEAD>
	<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="#000066">
		<!-- head: logo, controls -->
		<table class="main-panel" border="0" align="center" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td valign="middle" align="left">
					<img src="images/shim.gif" width="6" border="0"> <a href="http://ccnet.thoughtworks.com">
						<img src="images/ccnet_logo.gif" border="0"></a>
				</td>
			</tr>
		</table>
		<!-- body: main content panels -->
		<table class="TopControls" border="0" width="100%" border="0" bgcolor=#333399 cellpadding="3" cellspacing="0" height="25">
			<tr>
				<td valign="middle" align="left">
				&nbsp;
				</td>
			</tr>
		</table>
		<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%" bgcolor="#333399">
			<tr>
				<td valign="top" id="LeftHandSide" width="196" bgcolor=#eeeedd>
				    <table id="Plugins" width="100%" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								<asp:Panel id="ProjectPanel" runat="server">
									<TABLE cellSpacing="0" cellPadding="2" width="196" align="center" border="0">
										<TR>
											<TD>
												<asp:DataList id="ServerPluginsList" Runat="server"></asp:DataList></TD>
										</TR>
										<TR>
											<TD noWrap>
												<asp:DataList id="BuildPluginsList" Runat="server"></asp:DataList></TD>
										</TR>
										<TR>
											<TD><SPAN class="buildresults-header">BUILD RESULTS</SPAN></TD>
										</TR>
										<TR>
											<TD><SPAN class="buildresults-data" id="buildStats" runat="server" runAt="server"></SPAN></TD>
										</TR>
										<TR>
											<TD noWrap>
												<asp:DataList id="menu" Runat="server"></asp:DataList></TD>
										</TR>
									</TABLE>
								</asp:Panel>
							</td>
						</tr>
					</table>
				</td>
				<td width="2" />
				<td valign="top" bgcolor="#FFFFFF">
					<table border="0" align="center" cellpadding="3" cellspacing="0" width="100%">
						<tr>
							<td>
								<decorator:body id="Body1" runat="server"></decorator:body>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td height="2" colspan="3"></td></tr>
		</table>
		<!-- footer: twlogo -->
		<table width="100%">
			<tr>
				<td align="right">
					<a href="http://www.thoughtworks.com/" border="0"><img src="images/tw_dev_logo.gif" border="0"><img src="images/shim.gif" width="6" border="0">
					</a>
				</td>
			</tr>
		</table>
	</body>
</HTML>
