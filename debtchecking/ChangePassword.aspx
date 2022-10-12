<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="DebtChecking.ChangePassword" %>

<!DOCTYPE html PUBLIC "-//W3C//Ddiv XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Ddiv/xhtml1-transitional.ddiv">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Change Password</title>
    <script language="javascript" type="text/javascript">
        function kutip_satu() {
            if ((event.keyCode == 35) || (event.keyCode == 39)) {
                return false;
            } else {
                return true;
            }
        }
    </script>

    <Template:Admin runat="server" ID="Template" />
</head>
<body class="text-sm">
    <form id="form1" runat="server">
        <div class="card card-primary card-outline p-1">
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-6">
                        <div class="form-group row">
                            <div class="col-sm-3">
                                Old Password
                            </div>
                            <div class="col-sm-9">
                                <asp:TextBox onkeypress="return kutip_satu()" ID="TXT_OLD" runat="server" TextMode="Password" CssClass="form-control form-control-sm"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-3">
                                New Password
                            </div>
                            <div class="col-sm-9">
                                <asp:TextBox onkeypress="return kutip_satu()" ID="TXT_NEW" runat="server" TextMode="Password" CssClass="form-control form-control-sm"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-3">
                                Verify Password
                            </div>
                            <div class="col-sm-9">
                                <asp:TextBox onkeypress="return kutip_satu()" ID="TXT_VERIFY" runat="server" TextMode="Password" CssClass="form-control form-control-sm"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group row">

                            <div class="col-sm-3"></div>
                            <div class="col-sm-9">
                                <asp:Label ID="LBL_MESSAGE" runat="server" ForeColor="Red"></asp:Label>
                                <asp:Label ID="LBL_SC_ID" runat="server" Visible="False"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="row">
                            <div class="col-sm-3"></div>
                            <div class="col-sm-9">
                                <asp:Button ID="BTN_CHANGE" runat="server" Text="Change" CssClass="btn btn-primary" OnClick="BTN_CHANGE_Click"></asp:Button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>