<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParamSet.aspx.cs" Inherits="MikroMnt.Parameter.ParamSet" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>ParamSet Page</title>
	<link href="../include/style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
       <%-- <table width="100%">
            <tr>
                <td class="H0" align="right">
                    <a href="../Body.aspx"><img src="../image/MainMenu.JPG" alt="mainmenu" /></a>
                    <a href="../Logout.aspx" target="_top"><img src="../image/logout.jpg" alt="logout" /></a>
                </td>
            </tr>
        </table>--%>
        <table class="Box1" width="100%">
            <tr class="H1">
                <td>
                    <b><asp:Label ID="LBL_TITLE" runat="server"></asp:Label></b>
                </td>
            </tr>
            <tr>
                <td>
                    <dx:ASPxDataView ID="dataView" runat="server" onload="dataView_Load" >
                    <ItemStyle Height="1%" />
                    <ItemTemplate> 
                        <asp:HyperLink ID="lnk" runat="server" Text='<%# Eval("PARAMDESC") %>' NavigateUrl='<%# Eval("PARAMLINK") %>' ></asp:HyperLink>
                    </ItemTemplate>
                    <PagerSettings>
                        <AllButton Visible="True"></AllButton>
                    </PagerSettings>
                    </dx:ASPxDataView>
                </td>
            </tr>
        </table>
        
    </div>
    </form>
</body>
</html>
