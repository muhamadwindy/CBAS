<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="unittest.aspx.cs" Inherits="DebtChecking.unittest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="include/style.css" type="text/css" rel="Stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory">admin</asp:TextBox>--%>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory">adhika.priyotomo</asp:TextBox>--%>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory">aries.lesmana</asp:TextBox>--%>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory">desmi.ammelia</asp:TextBox>--%>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory">hadyan.luthfi</asp:TextBox>--%>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory">annisa.fajria</asp:TextBox>--%>
            <%--<asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory" Text="haryanto.wibowo"></asp:TextBox>--%>
            <asp:TextBox ID="TextBox1" runat="server" CssClass="mandatory" Text="BNS"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            <br />
            <br />
            <asp:TextBox ID="TextBox2" runat="server" TextMode="MultiLine" Rows="5">cmd</asp:TextBox>
            <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
        </div>
    </form>
</body>
</html>