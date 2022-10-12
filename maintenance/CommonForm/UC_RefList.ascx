﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UC_RefList.ascx.cs" Inherits="MikroMnt.CommonForm.UC_RefList" %>
<asp:DropDownList ID="DDL" runat="server" OnSelectedIndexChanged="DDL_REF_SelectedIndexChanged"></asp:DropDownList>
<div id="d1" runat="server">
    <input type="hidden" id="cd" runat="server" name="cd">
    <input type="hidden" id="de" runat="server" name="de">
    <iframe id="fr" frameborder="no" width="100%" scrolling="no" height="35" runat="server"
        tabindex="-1"></iframe>
</div>
<div id="d2" runat="server">
    <asp:TextBox ID="CODE" runat="server" AutoPostBack="True" Width="50px" OnTextChanged="CODE_TextChanged" CssClass="form-control form-control-sm"></asp:TextBox>
    <input id="BTN" class="btn btn-sm btn-success" type="button" value="Cari" runat="server" tabindex="-1" name="BTN">
    <asp:TextBox ID="DESC" runat="server" Width="100%" ReadOnly="True" BorderWidth="0px" CssClass="form-control form-control-sm"
        TabIndex="-1"></asp:TextBox>
</div>
