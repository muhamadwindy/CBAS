<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="USC_paraminput.ascx.cs" Inherits="MikroMnt.Parameter.USC_paraminput" %> 

<table  class="Box1" width="100%" >
<tr>
    <td align="center">
    <pre dir="ltr" style="
		margin: 0px;
		padding: 2px;
		border: 1px inset;
		width: 700px;
		height: 400px;
		text-align: left;
		overflow: auto">
        <asp:Table ID="TableInput" runat="server" Width="100%">
        </asp:Table>
    </pre>
    </td>
</tr>
<tr>
    <td runat="server" id="td_filter" align="center" >
        <input id="Button1" runat="server" class="Bt1" type="button" value=" Save " onclick="panel.PerformCallback('s:')" />
        <input id="clrButton" runat="server" class="Bt1" type="button" value=" Clear " style="display:none"/>
        <input id="Button2" runat="server" class="Bt1" type="button" value=" Cancel " onclick="popup.Hide();" />
        
    </td>
</tr>
</table>
