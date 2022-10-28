<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Modal_Content_SlikLogin_Viewer.aspx.cs" Inherits="DebtChecking.SLIK.Modal_Content_SlikLogin_Viewer" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SID Text Page</title>
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <div class="text-sm">
        <form id="form1" runat="server">
            <div class="container-fluid">
                <div class="form-group row">
                    <div class="col-sm-4">User ID</div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="userid" CssClass="form-control form-control-sm numeric" required="required"></asp:TextBox>
                    </div>
                </div>


                <div class="form-group row">
                    <div class="col-sm-4">User ID SLIK</div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="uid_slik" CssClass="form-control form-control-sm numeric" required="required"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-4">Password</div>
                    <div class="col-sm-8">
                        <asp:TextBox runat="server" ID="pwd_viewer" CssClass="form-control form-control-sm numeric" TextMode="Password" required="required"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-4">Active</div>
                    <div class="col-sm-8">
                        <asp:DropDownList runat="server" ID="user_aktif" CssClass="form-control form-control-sm">
                            <asp:ListItem Text="Non-Aktif" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Aktif" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="form-group row">
                    <div class="col-sm-4"></div>
                    <div class="col-sm-8">
                        <asp:Button ID="btn_cnl" runat="server" Text="Cancel" OnClick="ActCnl" CssClass="btn btn-sm btn-success" formnovalidate />
                        <asp:Button ID="btn_save" runat="server" Text="Save" OnClick="ActSv" CssClass="btn btn-sm btn-success" />
                    </div>
                </div>

            </div>
        </form>
    </div>
</body>
</html>
