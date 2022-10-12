<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserMaintenance.aspx.cs"
    Inherits="MikroMnt.user.UserMaintenance" %>

<%@ Register TagPrefix="uc1" TagName="UC_RefList" Src="../CommonForm/UC_RefList.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <Template:Admin runat="server" ID="Template" />
    <title>UserMaintenance</title>
    <link href="../include/style.css" type="text/css" rel="stylesheet" />
    <!-- #include file="../include/cek_mandatoryOnly.html" -->
    <!-- #include file="~/include/onepost.html" -->

    <script language="javascript" type="text/javascript">
        function simpan() {
            var childfrm = document.IFR_MODULE.document.form1;
            var vuser = document.form1.TXT_USERID;
            var branch = document.form1.uREF_BRANCHID_CODE;
            if (branch == null)
                branch = document.form1.uREF_BRANCHID_DDL;
            if (childfrm != null) {
                childfrm.uid.value = vuser.value;
                childfrm.sta.value = "save";
                childfrm.br.value = branch.value;
                childfrm.submit();
            }
        }

        function showpwdmsg() {
            //   if (!form1.panelNama_TXT_SU_PWD.disabled && form1.panelNama_TXT_SU_PWD.dataFld == '')
            //{
            //       form1.panelNama_TXT_SU_PWD.dataFld = '1';
            //	alert(form1.pwdmsg.value);
            //}
        }

        function tabE(e) {
            var e = (typeof event != 'undefined') ? window.event : e; // IE : Moz
            if (e.keyCode == 13) { e.keyCode = 9; return e.keyCode }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="card p-2">

                <div class="row">
                    <div class="col-sm-12">
                        <h4>Parameter Maker: User Maintenance
                        </h4>
                        <hr />

                        <div class="row">
                            <div class="col-sm-12">
                                <h5>Existing Data</h5>
                                <hr />
                                <div class="row">
                                    <div class="col-sm-6">
                                        <table class="table table-sm table-responsive">
                                            <tr>
                                                <td>Module</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:DropDownList ID="DDL_RFMODULE" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                                    <input id="pwdmsg" type="hidden" name="pwdmsg" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Group</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:DropDownList ID="DDL_RFGROUP" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Branch</td>
                                                <td>:</td>
                                                <td>
                                                    <uc1:UC_RefList ID="uREF_BRANCH" runat="server"></uc1:UC_RefList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>User ID</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:TextBox ID="TXT_SEARCH_USERID" runat="server" CssClass="form-control form-control-sm"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-sm-6">
                                        <table class="table table-sm table-responsive">
                                            <tr>
                                                <td>Full Name</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:TextBox ID="TXT_SEARCH_USERNAME" runat="server" CssClass="form-control form-control-sm"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>Upliner 1</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:TextBox ID="TXT_SEARCH_UPLINER" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Upliner 2</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:TextBox ID="TXT_SEARCH_UPLINER2" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>Upliner 3</td>
                                                <td>:</td>
                                                <td>
                                                    <asp:TextBox ID="TXT_SEARCH_UPLINER3" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>&nbsp;</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">

                                        <asp:Button ID="BTN_SEARCH" runat="server" Width="100px" Text="Search" CssClass="btn btn-sm btn-primary m-2" OnClick="BTN_SEARCH_Click"></asp:Button>
                                        <asp:Button ID="BTN_CLEAR" runat="server" Width="100px" Text="Clear" CssClass="btn btn-sm btn-default m-2" OnClick="BTN_CLEAR_Click"></asp:Button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <asp:DataGrid ID="DatGrd" runat="server" Width="100%" AllowSorting="True" AutoGenerateColumns="False"
                                            CellPadding="1" AllowPaging="True" OnItemCommand="DatGrd_ItemCommand"
                                            OnPageIndexChanged="DatGrd_PageIndexChanged" OnSortCommand="DatGrd_SortCommand" CssClass="table table-sm table-responsive table-bordered">
                                            <HeaderStyle CssClass="H2"></HeaderStyle>
                                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                            <Columns>
                                                <asp:BoundColumn Visible="False" DataField="MODULEID"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="MODULENAME" SortExpression="MODULENAME" HeaderText="Module"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="USERID" SortExpression="USERID" HeaderText="User ID"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="SU_FULLNAME" SortExpression="SU_FULLNAME" HeaderText="Full Name">
                                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                </asp:BoundColumn>
                                                <asp:BoundColumn Visible="False" DataField="GROUPID"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="SG_GRPNAME" SortExpression="SG_GRPNAME" HeaderText="Group"></asp:BoundColumn>
                                                <asp:BoundColumn Visible="False" DataField="BRANCHID" HeaderText="Branch ID"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="BRANCHNAME" SortExpression="BRANCHNAME" HeaderText="Branch"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="SU_LOGON" HeaderText="Logon"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="SU_REVOKE" HeaderText="Revoke" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="SU_ACTIVE" HeaderText="Active" Visible="false"></asp:BoundColumn>
                                                <asp:BoundColumn DataField="JenisUserDesc" HeaderText="Jenis User"></asp:BoundColumn>
                                                <asp:TemplateColumn HeaderText="Function">
                                                    <ItemStyle HorizontalAlign="Center" Width="75px"></ItemStyle>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="lnkEdit" runat="server" CommandName="edit">Edit</asp:LinkButton>&nbsp;
										<asp:LinkButton ID="lnkDelete" runat="server" CommandName="delete">Delete</asp:LinkButton>&nbsp;
										<asp:LinkButton ID="lnkUndelete" runat="server" CommandName="undelete">UnDelete</asp:LinkButton>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:BoundColumn Visible="False" DataField="inpending"></asp:BoundColumn>
                                            </Columns>
                                            <PagerStyle Mode="NumericPages"></PagerStyle>
                                        </asp:DataGrid>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <asp:Label ID="LBL_RESULT" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h6>Detail Information</h6>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <table class="table table-sm table-responsive">
                                                    <tr>
                                                        <td valign="top">
                                                            <dx:ASPxCallbackPanel ID="panelNama" runat="server" ClientInstanceName="panelNama"
                                                                OnCallback="panelNama_Callback">
                                                                <PanelCollection>
                                                                    <dx:PanelContent ID="PanelContent2" runat="server">
                                                                        <table class="table table-sm table-responsive">
                                                                            <tr>
                                                                                <td>UserID</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TXT_USERID" runat="server" CssClass="form-control form-control-sm mandatory"></asp:TextBox>
                                                                                    <input type="button" class="btn btn-sm" id="btn_cekAD" runat="server" value="Cek AD User" onclick="callbackpopup(popup, panel, 'new');" />&nbsp;
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Full Name</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TXT_SU_FULLNAME" runat="server" Width="250px" CssClass="form-control form-control-sm mandatory" onchange="document.form1.panelNama_hdn_nama.value=this.value;"></asp:TextBox>
                                                                                    <input type="hidden" id="hdn_nama" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Group</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:DropDownList ID="DDL_GROUPID" runat="server" Width="250px" AutoPostBack="True" CssClass="form-control form-control-sm mandatory" OnSelectedIndexChanged="DDL_GROUPID_SelectedIndexChanged"></asp:DropDownList></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Password</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TXT_SU_PWD" runat="server" CssClass="form-control form-control-sm mandatory" TextMode="Password"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Verify</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TXT_VERIFYPWD" runat="server" CssClass="form-control form-control-sm mandatory" TextMode="Password"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>HP No.</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TXT_SU_HPNUM" runat="server" CssClass="form-control form-control-sm"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>Email</td>
                                                                                <td>:</td>
                                                                                <td>
                                                                                    <asp:TextBox ID="TXT_SU_EMAIL" runat="server" Width="250px" CssClass="form-control form-control-sm" onchange="document.form1.panelNama_hdn_email.value=this.value;"></asp:TextBox>
                                                                                    <input type="hidden" id="hdn_email" runat="server" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </dx:PanelContent>
                                                                </PanelCollection>
                                                            </dx:ASPxCallbackPanel>
                                                            <table class="table table-sm table-responsive">
                                                                <tr>
                                                                    <td>Branch</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <uc1:UC_RefList ID="uREF_BRANCHID" runat="server"></uc1:UC_RefList>
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>Area</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <uc1:UC_RefList ID="uREF_AREAID" runat="server" CssClass="form-control form-control-sm"></uc1:UC_RefList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Upliner 1</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <uc1:UC_RefList ID="uREF_UPLINER" runat="server"></uc1:UC_RefList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Upliner 2</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <uc1:UC_RefList ID="uREF_UPLINER2" runat="server"></uc1:UC_RefList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Upliner 3</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <uc1:UC_RefList ID="uREF_UPLINER3" runat="server"></uc1:UC_RefList>
                                                                    </td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>Jenis User</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddl_JenisUser" runat="server" CssClass="form-control form-control-sm">
                                                                            <asp:ListItem Value="" Text="- PILIH -"></asp:ListItem>
                                                                            <asp:ListItem Value="1" Text="Active Directory"></asp:ListItem>
                                                                            <asp:ListItem Value="2" Text="User Local"></asp:ListItem>
                                                                        </asp:DropDownList></td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>Jenis User</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:Label ID="lbl_jenisuser" runat="server"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Logon status</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:CheckBox ID="cb_logon" CssClass="form-control form-control-sm" runat="server" Text="(clear to reset)" AutoPostBack="True" OnCheckedChanged="cb_logon_CheckedChanged"></asp:CheckBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Revoke</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:CheckBox ID="cb_revoke" CssClass="form-control form-control-sm" runat="server" Text="(check for yes)"></asp:CheckBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>Active</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:CheckBox ID="CHK_SU_ACTIVE" CssClass="form-control form-control-sm" runat="server" Text="(check for yes)"></asp:CheckBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="3"></td>
                                                                </tr>
                                                                <tr style="display: none">
                                                                    <td>Password Reset (to default)</td>
                                                                    <td>:</td>
                                                                    <td>
                                                                        <asp:CheckBox ID="cb_resetpwd" runat="server" Text="(check for yes)"></asp:CheckBox></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td valign="top">
                                                            <table class="table table-sm table-responsive">
                                                                <tr>
                                                                    <td class="H2">Module</td>
                                                                </tr>
                                                                <tr>
                                                                    <td id="TD_UC" runat="server"></td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:RadioButtonList ID="RBL_MODULE" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                                                            RepeatLayout="Flow" OnSelectedIndexChanged="RBL_MODULE_SelectedIndexChanged" CssClass="form-control form-control-sm">
                                                                        </asp:RadioButtonList>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table class="table table-sm table-responsive">
                                                                <tr>
                                                                    <td>
                                                                        <iframe id="IFR_MODULE" tabindex="0" name="IFR_MODULE" frameborder="0" width="100%" height="150" runat="server"></iframe>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table cellspacing="0" cellpadding="0" width="100%">
                                                                <tr>
                                                                    <td align="center">
                                                                        <input class="btn btn-sm btn-primary" id="BtnSaveModule" type="button" value="Save" onclick="simpan()"></input>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="GridMappinProduct" runat="server" Width="100%" ShowHeaderWhenEmpty="true"
                                                                EmptyDataText="Product Not Found" AutoGenerateColumns="False" CssClass="table table-sm table-responsive table-bordered">
                                                                <Columns>
                                                                    <asp:BoundField Visible="False" DataField="productid"></asp:BoundField>
                                                                    <asp:BoundField DataField="productname" HeaderText="Produk"></asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Otorisasi">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# Bind("Auth") %>' />
                                                                            <asp:HiddenField ID="productid" runat="server"
                                                                                Value='<%# Bind("productid") %>' />
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <asp:Button ID="BTN_NEW_AD" runat="server" Text="New AD User" Style="display: none" CssClass="btn btn-sm btn-primary"
                                            OnClick="BTN_NEW_AD_Click"></asp:Button>&nbsp;
					    <asp:Button ID="BTN_NEW" runat="server" Text="New User" CssClass="btn btn-sm btn-primary" OnClick="BTN_NEW_Click"></asp:Button>
                                        &nbsp;
					    <asp:Button ID="BTN_SAVE" runat="server" Width="70px" Text="Submit" CssClass="btn btn-sm btn-success" Visible="False" OnClick="BTN_SAVE_Click"></asp:Button>&nbsp;
						<asp:Button ID="BTN_CANCEL" runat="server" Width="70px" Text="Cancel" CssClass="btn btn-sm btn-default" Visible="False" OnClick="BTN_CANCEL_Click"></asp:Button>
                                        <asp:Label ID="LBL_SAVEMODE" runat="server" Visible="False">1</asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <dx:ASPxPopupControl ID="popup" ClientInstanceName="popup" runat="server" HeaderText="Login AD as" Width="300px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseAction="CloseButton" Modal="True" AllowDragging="True" EnableAnimation="False">
                <ContentCollection>
                    <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" Height="100%">
                        <dx:ASPxCallbackPanel ID="panel" runat="server" ClientInstanceName="panel"
                            OnCallback="panel_Callback">
                            <PanelCollection>
                                <dx:PanelContent ID="PanelContent1" runat="server">
                                    <table width="100%" class="table table-sm table-responsive">
                                        <tr>
                                            <td align="left">User</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox runat="server" ID="LDAPUser" onkeydown="tabE(event)" CssClass="form-control form-control-sm"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td align="left">Password</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox runat="server" ID="LDAPPwd" CssClass="form-control form-control-sm" TextMode="Password" onkeydown="tabE(event)"></asp:TextBox>
                                                <asp:TextBox runat="server" ID="LDAPPwd2" CssClass="form-control form-control-sm" Style="display: none"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <input type="button" class="btn btn-sm btn-info" runat="server" id="btnValidateUserAD" value="OK" onclick="callbackpopup(popup, panel, 'cek', panelNama);" />
                                                <input type="button" class="btn btn-sm btn-info" runat="server" id="btnCancelValidate" value="Cancel" onclick="popup.Hide();" />
                                            </td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxCallbackPanel>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:ASPxPopupControl>
        </div>
    </form>
</body>
</html>
