<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupApproval.aspx.cs" Inherits="MikroMnt.user.GroupApproval" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GroupApproval</title> 
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">

            <div class="row">
                <div class="col-sm-12">
                    <div class="text-center">
                        <b>Parameter Maker: Group Approval</b>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-12">
                    <asp:DataGrid ID="DG_REQUEST" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered">
                        <HeaderStyle CssClass="H1"></HeaderStyle>
                        <AlternatingItemStyle CssClass="Alt1"></AlternatingItemStyle>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                        <Columns>
                            <asp:BoundColumn DataField="GROUPID" HeaderText="Group ID"></asp:BoundColumn>
                            <asp:BoundColumn DataField="SG_GRPNAME" HeaderText="Group Description"></asp:BoundColumn>
                            <asp:BoundColumn DataField="SG_GRPUNAME" HeaderText="Group Upliner"></asp:BoundColumn>
                            <asp:BoundColumn Visible="False" DataField="MODULEIDS" HeaderText="MODULEIDS"></asp:BoundColumn>
                            <asp:BoundColumn DataField="MODULENAMES" HeaderText="Access Modules"></asp:BoundColumn>
                            <asp:BoundColumn Visible="False" DataField="CH_STA" HeaderText="CH_STA"></asp:BoundColumn>
                            <asp:BoundColumn DataField="STATUS" HeaderText="Status"></asp:BoundColumn>
                            <asp:BoundColumn DataField="REQUESTBY" HeaderText="REQUESTED BY"></asp:BoundColumn>
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
                        </Columns>
                    </asp:DataGrid>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <asp:Button ID="BTN_SUBMIT" runat="server" Width="87px" CssClass="btn btn-sm btn-info" Text="Submit" OnClick="BTN_SUBMIT_Click"></asp:Button>
                </div>
            </div>

        </div>


    </form>
</body>
</html>
