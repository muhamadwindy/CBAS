<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Modal_Content_SlikTasklist_Extract.aspx.cs" Inherits="DebtChecking.SLIK.Modal_Content_SlikTasklist_Extract" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SLIK Tasklist Extract</title>
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="container-fluid text-sm">
            <div class="form-group row">
                <div class="col-md-4">Userid CBAS</div>
                <div class="col-md-8">
                    <asp:TextBox runat="server" ID="userid" CssClass="form-control form-control-sm numeric" required="required"></asp:TextBox>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-md-4 top-buffer4">Service ID</div>
                <div class="col-md-8">
                    <asp:TextBox runat="server" ID="serviceid" CssClass="form-control form-control-sm numeric" required="required"></asp:TextBox>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-md-4 top-buffer4"></div>
                <div class="col-md-8">
                    <asp:Button ID="btn_cnl" runat="server" Text="Cancel" OnClick="ActCnl" CssClass="btn btn-sm btn-success" formnovalidate />
                    <asp:Button ID="btn_save" runat="server" Text="Save" OnClick="ActSv" CssClass="btn btn-sm btn-success" />
                </div>
            </div>
        </div>

    </form>
</body>
</html>
