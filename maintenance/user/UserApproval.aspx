<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserApproval.aspx.cs" Inherits="MikroMnt.user.UserApproval" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>UserApproval</title>
    <script src="../App_Themes/mwstyle/plugins/jquery/jquery.min.js"></script>
    <link href="../App_Themes/mwstyle/dist/css/adminlte.min.css" rel="stylesheet" />
    <style>
        .hidden {
            display: none;
        }
    </style>
    <!-- #include file="~/include/onepost.html" -->
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <div class="card p-2">

                <div class="row">
                    <div class="col-sm-12">
                        <b>Parameter Approval: User Maintenance</b>
                    </div>
                    <hr />
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="table-responsive">
                            <asp:datagrid ID="DG_REQUEST" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-sm table-bordered table-striped" ShowHeaderWhenEmpty="true" EmptyDataText="Data Not Found">
                                <Columns>
                                    <asp:BoundColumn DataField="USERID" HeaderText="User ID"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="SU_FULLNAME" HeaderText="Full Name">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundColumn>
                                    <asp:BoundColumn DataField="SG_GRPNAME" HeaderText="Group">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundColumn> 
                                    <asp:TemplateColumn HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="STATUSID" runat="Server" Value='<%# Eval("CH_STA") %>' />
                                        </ItemTemplate> 
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn DataField="STATUS" HeaderText="Status"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="SU_REGISTERBY" HeaderText="REQUESTED BY"></asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText="Accept">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="RDO_APPROVE" runat="server" GroupName="function"></asp:RadioButton>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Reject">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="RDO_REJECT" runat="server" GroupName="function"></asp:RadioButton>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Pending">
                                        <ItemTemplate>
                                            <asp:RadioButton ID="RDO_PENDING" runat="server" GroupName="function" Checked="True"></asp:RadioButton>
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                    <asp:BoundColumn Visible="False" DataField="GROUPID" HeaderText="groupid"></asp:BoundColumn>
                                    <asp:TemplateColumn HeaderText=" ">
                                        <ItemStyle HorizontalAlign="Center" Width="75px"></ItemStyle>
                                        <ItemTemplate>
                                            <a href="#" id="lnkDetail" data-userid='<%# Eval("USERID") %>' class="bukakPopup">Detail</a>&nbsp;
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:datagrid>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:Button ID="BTN_SUBMIT" runat="server" Width="87px" CssClass="btn btn-sm btn-primary" Text="Submit" OnClick="BTN_SUBMIT_Click"></asp:Button>
                    </div>
                </div>
            </div>

        </div>

        <dx:ASPxPopupControl ID="popup" ClientInstanceName="popup" runat="server" ShowHeader="false" HeaderText="Detail Changes" Width="500px" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" CloseAction="CloseButton" Modal="True" AllowDragging="True" EnableAnimation="False">
            <ContentCollection>
                <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" Height="100%">
                    <dx:ASPxCallbackPanel ID="panel" runat="server" ClientInstanceName="panel"
                        OnCallback="panel_Callback">
                        <PanelCollection>
                            <dx:PanelContent ID="PanelContent1" runat="server">
                                <h6>Jenis Perubahan :
                                <asp:Label ID="ch_type" Font-Bold="true" runat="server"></asp:Label>
                                </h6>
                                <table width="100%" class="table table-sm">
                                    <tr>
                                        <td width="20%" style="border-right: dotted 1px black;">&nbsp;</td>
                                        <td width="40%" style="border-right: dotted 1px black;" align="center"><b>BEFORE</b></td>
                                        <td width="40%" align="center"><b>AFTER</b></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><b>UserId</b></td>
                                        <td style="border-right: dotted 1px black; background-color: lightblue">
                                            <asp:Label ID="bf_userid" runat="server"></asp:Label></td>
                                        <td style="background-color: lightblue">
                                            <asp:Label ID="af_userid" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><b>User Name</b></td>
                                        <td style="border-right: dotted 1px black;">
                                            <asp:Label ID="bf_username" runat="server"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="af_username" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Group</strong></td>
                                        <td style="border-right: dotted 1px black; background-color: lightblue">
                                            <asp:Label ID="bf_group" runat="server"></asp:Label></td>
                                        <td style="background-color: lightblue">
                                            <asp:Label ID="af_group" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Email</strong></td>
                                        <td style="border-right: dotted 1px black;">
                                            <asp:Label ID="bf_email" runat="server"></asp:Label>&nbsp;</td>
                                        <td>
                                            <asp:Label ID="af_email" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>No HP</strong></td>
                                        <td style="border-right: dotted 1px black; background-color: lightblue">
                                            <asp:Label ID="bf_hp" runat="server"></asp:Label>&nbsp;</td>
                                        <td style="background-color: lightblue">
                                            <asp:Label ID="af_hp" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Cabang</strong></td>
                                        <td style="border-right: dotted 1px black;">
                                            <asp:Label ID="bf_cabang" runat="server"></asp:Label>&nbsp;</td>
                                        <td>
                                            <asp:Label ID="af_cabang" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Upliner 1</strong></td>
                                        <td style="border-right: dotted 1px black; background-color: lightblue">
                                            <asp:Label ID="bf_upliner1" runat="server"></asp:Label>&nbsp;</td>
                                        <td style="background-color: lightblue">
                                            <asp:Label ID="af_upliner1" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Upliner 2</strong></td>
                                        <td style="border-right: dotted 1px black;">
                                            <asp:Label ID="bf_upliner2" runat="server"></asp:Label>&nbsp;</td>
                                        <td>
                                            <asp:Label ID="af_upliner2" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Upliner 3</strong></td>
                                        <td style="border-right: dotted 1px black; background-color: lightblue">
                                            <asp:Label ID="bf_upliner3" runat="server"></asp:Label>&nbsp;</td>
                                        <td style="background-color: lightblue">
                                            <asp:Label ID="af_upliner3" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Status Aktif</strong></td>
                                        <td style="border-right: dotted 1px black;">
                                            <asp:Label ID="bf_status" runat="server"></asp:Label></td>
                                        <td>
                                            <asp:Label ID="af_status" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td style="border-right: dotted 1px black;"><strong>Locked</strong></td>
                                        <td style="border-right: dotted 1px black; background-color: lightblue">
                                            <asp:Label ID="bf_locked" runat="server"></asp:Label></td>
                                        <td style="background-color: lightblue">
                                            <asp:Label ID="af_locked" runat="server"></asp:Label></td>
                                    </tr>
                                </table>

                                <hr />
                                <div class="row">
                                    <div class="col-sm-6">
                                        <h6>Mapping Product Before</h6>
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridMappingProductBEFORE" runat="server" Width="100%" ShowHeaderWhenEmpty="true"
                                                EmptyDataText="-" AutoGenerateColumns="False" CssClass="table table-sm table-bordered">
                                                <Columns>
                                                    <asp:BoundField Visible="False" DataField="productid"></asp:BoundField>
                                                    <asp:BoundField DataField="productname" HeaderText="Produk"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <h6>Mapping Product After</h6>
                                        <div class="table-responsive">
                                            <asp:GridView ID="GridMappingProductAFTER" runat="server" Width="100%" ShowHeaderWhenEmpty="true"
                                                EmptyDataText="Product Not Found" AutoGenerateColumns="False" CssClass="table table-sm table-bordered">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="No.">
                                                        <ItemTemplate>
                                                            <%# Container.DataItemIndex %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField Visible="False" DataField="productid"></asp:BoundField>
                                                    <asp:BoundField DataField="productname" HeaderText="Produk"></asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-sm-12 text-center">
                                        <input type="button" class="btn btn-sm btn-primary" onclick="popup.Hide()" value="Close" />
                                    </div>
                                </div>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

    </form>
</body>

<script>
    $('.bukakPopup').on("click", function () {
        var userid = $(this).data('userid');
        callbackpopup(popup, panel, 'r:' + userid)
    });
</script>

</html>
