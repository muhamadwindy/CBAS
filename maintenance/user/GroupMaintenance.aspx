<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupMaintenance.aspx.cs" Inherits="MikroMnt.user.GroupMaintenance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GroupMaintenance</title>
    <link href="../include/style.css" type="text/css" rel="stylesheet" />
    <!-- #include file="../include/cek_mandatoryOnly.html" -->
    <script language="javascript" type="text/javascript">
        function simpan() {
            var childfrm = document.IFR_MODULE.document.form1;
            var vgid = document.form1.TXT_GROUPID;
            if (childfrm != null) {
                childfrm.gid.value = vgid.value;
                childfrm.sta.value = "save";
                childfrm.submit();
            }
        }
        function resizeFrame() {
            try {
                var oBody = document.IFR_MODULE.document.body;
                var oFrame = document.getElementById('IFR_MODULE');
                oFrame.style.width = "100%"
                var h = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight) + 20;
                if (h < 150)
                    h = 150;
                oFrame.style.height = h;
                oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
            }
            //An error is raised if the IFrame domain != its container's domain
            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }
        }
		</script>

    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <table class="Box1" width="100%">
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td class="H0">
                                    <table>
                                        <tr>
                                            <td class="H1" style="width: 400px" align="center">
                                                <b>Parameter Maker: Group Maintenance</b>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <%--	<td class="H0" align="right">
								    <a href="../Body.aspx"><img src="../Image/MainMenu.jpg" alt="mainmenu" /></a>
								    <a href="../Logout.aspx" target="_top"><img src="../Image/Logout.jpg" alt="logout" /></a>
								</td>--%>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="H1">Existing Data</td>
                </tr>
                <tr>
                    <td>
                        <table class="table table-sm table-responsive">
                            <tr>
                                <td valign="top" width="50%">
                                    <table class="table table-sm table-responsive">
                                        <tr>
                                            <td>Module</td>
                                            <td>:</td>
                                            <td>
                                                <asp:DropDownList ID="DDL_MODULEID" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top">
                                    <table class="table table-sm table-responsive">
                                        <tr>
                                            <td>Group Name</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox ID="TXT_FINDGROUP" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Group Upliner</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox ID="TXT_FINDUPLINER" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="BTN_SEARCH" runat="server" CssClass="btn btn-sm btn-info" Text="Search" Width="100px" OnClick="BTN_SEARCH_Click"></asp:Button>&nbsp;
								
                                    <asp:Button ID="BTN_CLEARSEARCH" runat="server" Text="Clear" CssClass="btn btn-sm btn-info" Width="100px" OnClick="BTN_CLEARSEARCH_Click"></asp:Button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:DataGrid ID="DatGrd" runat="server" Width="100%"
                            AllowSorting="True" AllowPaging="True" AutoGenerateColumns="False"
                            CellPadding="1" OnItemCommand="DatGrd_ItemCommand" OnPageIndexChanged="DatGrd_PageIndexChanged"
                            OnSortCommand="DatGrd_SortCommand">
                            <HeaderStyle CssClass="H2"></HeaderStyle>
                            <AlternatingItemStyle CssClass="Alt1"></AlternatingItemStyle>
                            <ItemStyle HorizontalAlign="Center"></ItemStyle>
                            <Columns>
                                <asp:BoundColumn DataField="MODULEID" SortExpression="MODULEID" HeaderText="Module ID"></asp:BoundColumn>
                                <asp:BoundColumn DataField="MODULENAME" SortExpression="MODULENAME" HeaderText="Module Name"></asp:BoundColumn>
                                <asp:BoundColumn DataField="GROUPID" SortExpression="GROUPID" HeaderText="Group ID"></asp:BoundColumn>
                                <asp:BoundColumn DataField="SG_GRPNAME" SortExpression="SG_GRPNAME" HeaderText="Group Name"></asp:BoundColumn>
                                <asp:BoundColumn DataField="MEMBEROF_AD" SortExpression="MEMBEROF_AD" HeaderText="Role AD"></asp:BoundColumn>
                                <asp:BoundColumn Visible="False" DataField="SG_ACTIVE"></asp:BoundColumn>
                                <asp:TemplateColumn HeaderText="Function">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk_menu" runat="server" CommandName="menuAccess">Menu Access</asp:LinkButton>&nbsp;
									
                                        <asp:LinkButton ID="lnk_edit" runat="server" CommandName="edit">Edit</asp:LinkButton>&nbsp;
									
                                        <asp:LinkButton ID="lnk_delete" runat="server" CommandName="delete">Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:BoundColumn Visible="False" DataField="sg_grpupliner"></asp:BoundColumn>
                            </Columns>
                            <PagerStyle Mode="NumericPages"></PagerStyle>
                        </asp:DataGrid>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Label ID="LBL_RESULT" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                </tr>
                <tr>
                    <td class="H1" valign="top">Detail Information</td>
                </tr>
                <tr>
                    <td>
                        <table class="table table-sm table-responsive">
                            <tr>
                                <td valign="top" width="0%">
                                    <table class="table table-sm table-responsive">
                                        <tr>
                                            <td>Group ID</td>
                                            <td></td>
                                            <td>
                                                <asp:TextBox ID="TXT_GROUPID" runat="server" CssClass="form-control form-control-sm mandatory"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>Group Name</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox ID="TXT_SG_GRPNAME" runat="server" Width="175px" CssClass="form-control form-control-sm mandatory"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>Enable Save & Recalculate</td>
                                            <td>:</td>
                                            <td>
                                                <asp:CheckBox ID="CHK_SG_APPRSTA" runat="server" Text="(check for enable access)"></asp:CheckBox></td>
                                        </tr>
                                        <tr>
                                            <td>CBAS Client</td>
                                            <td>:</td>
                                            <td>
                                                <asp:CheckBox ID="CHK_SG_CALCULATOR" runat="server" Text="(check for enable access)"></asp:CheckBox></td>
                                        </tr>
                                        <tr>
                                            <td>Supervisor Role</td>
                                            <td>:</td>
                                            <td>
                                                <asp:CheckBox ID="FLAG_SUPERVISOR" runat="server" Text="(check for true)"></asp:CheckBox></td>
                                        </tr>
                                        <tr>
                                            <td>Group Upliner</td>
                                            <td>:</td>
                                            <td>
                                                <asp:DropDownList ID="DDL_SG_GRPUPLINER" runat="server" Width="250px" CssClass="form-control form-control-sm"></asp:DropDownList></td>
                                        </tr>
                                        <tr style="display: none">
                                            <td>Role AD</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox ID="MEMBEROF_AD" runat="server" Width="100px" MaxLength="10" Text="" /></td>
                                        </tr>
                                        <tr>
                                            <td>Module Access</td>
                                            <td>:</td>
                                            <td>
                                                <asp:CheckBoxList ID="CHK_MODULEID" runat="server" Width="100%"
                                                    RepeatColumns="1" AutoPostBack="True" RepeatDirection="Vertical"
                                                    OnSelectedIndexChanged="CHK_MODULEID_SelectedIndexChanged">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Group/Role Description</td>
                                            <td>:</td>
                                            <td>
                                                <asp:TextBox ID="SG_ROLEDESC" runat="server" TextMode="MultiLine" Width="95%" Rows="8"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top" width="50%">
                                    <table class="table table-sm table-responsive">
                                        <tr>
                                            <td class="H2">Module</td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:RadioButtonList ID="RBL_MODULE" runat="server" AutoPostBack="True" RepeatDirection="Horizontal"
                                                    RepeatLayout="Flow" OnSelectedIndexChanged="RBL_MODULE_SelectedIndexChanged">
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
                                            <td class="F1" align="center">
                                                <input class="btn btn-sm btn-primary" id="BtnSaveModule" type="button" value="Save" onclick="simpan()"></input>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="F1" valign="top" align="center">
                        <asp:Button ID="BTN_NEW" runat="server" Text="New" Width="70px" CssClass="btn btn-sm btn-success" OnClick="BTN_NEW_Click"></asp:Button>&nbsp;
					
                        <asp:Button ID="BTN_SAVE" runat="server" Text="Save" Width="70px" Visible="False" CssClass="Bt1" OnClick="BTN_SAVE_Click"></asp:Button>&nbsp;
					
                        <asp:Button ID="BTN_CANCEL" runat="server" Text="Cancel" Width="70px" Visible="False" CssClass="Bt1" OnClick="BTN_CANCEL_Click"></asp:Button>
                        <asp:Label ID="LBL_SAVEMODE" runat="server" Visible="False">1</asp:Label>
                    </td>
                </tr>
            </table>

        </div>
    </form>
</body>
</html>
