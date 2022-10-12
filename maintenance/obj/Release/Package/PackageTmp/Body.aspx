<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Body.aspx.cs" Inherits="MikroMnt.Body" %>

<%@ Register TagPrefix="dxm" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <Template:Admin runat="server" ID="Template" />
    <title>Body</title>
</head>
<body class="hold-transition sidebar-mini layout-fixed text-sm">
    <form id="form1" runat="server">
        <div>

            <dxm:ASPxMenu ID="menu" runat="server"
                CssFilePath="~/App_Themes/Office2003 Blue/{0}/styles.css" CssPostfix="Office2003_Blue"
                ImageFolder="~/App_Themes/Office2003 Blue/{0}/" ItemSpacing="1px"
                SeparatorColor="Transparent" SeparatorHeight="14px" SeparatorWidth="2px"
                BorderBetweenItemAndSubMenu="HideRootOnly" ShowPopOutImages="True">
                <itemstyle horizontalalign="Left" />
                <itemsubmenuoffset firstitemx="2" firstitemy="-12" lastitemx="2"
                    lastitemy="-12" x="2" y="-12" />
                <submenustyle gutterwidth="17px" />
                <separatorpaddings paddingbottom="1px" paddingright="0px" />
            </dxm:ASPxMenu>

            <table width="100%">
                <tr>
                    <td align="center" valign="top">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td align="right" colspan="3" valign="top">
                                    <asp:Label ID="Label1" runat="server" Visible="False"></asp:Label>
                                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                            <tr>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
