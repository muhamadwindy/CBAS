<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="matrix.aspx.cs" Inherits="MikroMnt.parameter.matrix" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%" BackColor="Transparent" OnCallback="mainPanel_Callback"
            ClientInstanceName="mainPanel">
            <ClientSideEvents EndCallback="function(s, e) {
                if (s.cp_new != '' && s.cp_new != undefined) {
                    window.open(s.cp_new,'_parent');
                    s.cp_new = '';
                }

                if (s.cp_url != '' && s.cp_url != undefined) {
                    window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                    s.cp_url = '';
                }

                if (s.cp_alert != '' && s.cp_alert != undefined) {
                    alert(s.cp_alert);
                    s.cp_alert = '';
                }

            }" />
            <PanelCollection>
                <dx:PanelContent ID="PanelContent1" runat="server">
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h5>Matrix Settings</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group row">
                                            <label class="col-sm-6 col-form-label">Produk</label>
                                            <div class="col-sm-6">
                                                <asp:DropDownList ID="PRODUCTID" runat="server" onchange="changeproductid()" CssClass="form-control form-control-sm"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-6 col-form-label">Outstanding</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="BAKI_DEBET" runat="server" CssClass="form-control form-control-sm numeric" MaxLength="20"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-6 col-form-label">Hari Tunggakan Bulan Terakhir</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="HT_LAST_MONTH" runat="server" CssClass="form-control form-control-sm numeric" MaxLength="5"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-6 col-form-label">Hari Tunggakan 12 Bulan Terakhir</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="HT_LAST_12MONTH" runat="server" CssClass="form-control form-control-sm numeric" MaxLength="5"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-6 col-form-label">Plafon</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="PLAFON" runat="server" CssClass="form-control form-control-sm numeric" MaxLength="20"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-sm-6 col-form-label">Plafon Awal</label>
                                            <div class="col-sm-6">
                                                <asp:TextBox ID="PLAFON_AWAL" runat="server" CssClass="form-control form-control-sm numeric" MaxLength="20"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <input type="button" class="m-1 btn btn-primary"
                                    onclick="saveSetting()" value="Save" />
                            </div>
                        </div>
                    </div>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </form>
</body>
<script>
    function saveSetting() {
        callback(mainPanel, '');
    }
    function changeproductid() {
        callback(mainPanel, 'cproductid');
    }
</script>
</html>
