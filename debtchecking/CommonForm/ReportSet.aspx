<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportSet.aspx.cs" Inherits="DebtChecking.Report.ReportSet" MasterPageFile="~/webmaster.Master" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>ReportSet Page</title>
        <link href="../include/style.css" type="text/css" rel="stylesheet" />
    </head>
    <body>
        <form id="form1">
            <div>
                <table class="Box1" width="100%">
                    <tr>
                        <td>
                            <dx:ASPxDataView ID="dataView" runat="server" OnLoad="dataView_Load">
                                <ItemStyle Height="1%" />
                                <ItemTemplate>
                                    <asp:HyperLink ID="lnk" runat="server" Text='<%# Eval("PV_DESC") %>' NavigateUrl='<%# Eval("PV_URL") %>'></asp:HyperLink>
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
</asp:Content>