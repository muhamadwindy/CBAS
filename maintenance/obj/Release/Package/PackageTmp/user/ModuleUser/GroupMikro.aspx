﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupMikro.aspx.cs" Inherits="MikroMnt.user.ModuleUser.GroupMikro" %>

<%@ Register TagPrefix="cc1" Namespace="DMSControls" Assembly="DMSControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
        <title>Group Maintenance</title>
		<link href="../../include/style.css" type="text/css" rel="stylesheet" />
		<!-- #include file="../../include/cek_mandatoryOnly.html" -->
        <script src="../../include/UC_Currency.js" language="javascript" type="text/javascript"></script>
        <script src="../../include/cek_entries.js" language="javascript" type="text/javascript"></script>
        <script src="../../include/calc.js" language="javascript" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
			<input type="hidden" id="sta" name="sta"></input>
			<input type="hidden" id="gid" name="gid"></input>
            <table class="Box1" width="100%">
                <tr>
					<td>
                <fieldset><legend>Bisnis Segmen Authority</legend>
			        <table class="table table-sm table-responsive">
				    <tr>
					    <td>
                            <asp:CheckBoxList id="CBL_SEGMEN" runat="server" RepeatDirection="Vertical"
                                RepeatLayout="Flow"></asp:CheckBoxList>
                        </td>
				    </tr>
                    </table>
                </fieldset>
                        </td>
                </tr>
				<tr style="display:none">
					<td>
					    <fieldset><legend>Screenmenu Authority</legend>
					    <table class="table table-sm table-responsive">
					        <tr valign="top">
					            <td>
					                <asp:DropDownList ID="dfc_MENUID" runat="server"></asp:DropDownList>
					                &nbsp;
					                <asp:Button ID="BTN_ADD2" runat="server" Text="add" onclick="BTN_ADD2_Click" />
					            </td>
					        </tr>
					        <tr>
					            <td>
                                    <asp:GridView ID="grdview2" runat="server" AutoGenerateColumns="false" 
                                        AllowPaging="true" PageSize="3" width="100%" CssClass="Dg1" 
                                        onrowcommand="grdview2_RowCommand" 
                                        OnRowDeleting="grdview2_RowDeleting" 
                                        OnRowEditing="grdview2_RowEditing" 
                                        onpageindexchanged="grdview2_PageIndexChanged" 
                                        onpageindexchanging="grdview2_PageIndexChanging" >
                                        <HeaderStyle CssClass="H1" />
                                        <AlternatingRowStyle CssClass="Alt1" />
                                        <RowStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:BoundField DataField="MENUDESC" HeaderText="Deviation Reason" >
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Function">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkdel" runat="server" Text="delete" CommandName="delete" CommandArgument='<%# Eval("MENUID") %>' ></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
					            </td>
					        </tr>
					    </table>
					    </fieldset>
					</td>
				</tr>
			</table>
	
    </div>
    </form>
</body>
</html>
