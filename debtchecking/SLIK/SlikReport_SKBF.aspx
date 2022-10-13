<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SlikReport_SKBF.aspx.cs" Inherits="DebtChecking.SLIK.SlikReport_SKBF" EnableEventValidation="false" %>

<%@ Register Src="../CommonForm/UC_UploadedFile.ascx" TagName="UC_UploadedFile" TagPrefix="uc3" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <Template:Admin runat="server" ID="Template" />
</head>

<body class="text-sm container-fluid">
    <form id="form1" runat="server">
        <div class="card card-primary card-outline">
            <div class="card-header">
                <h4 class="card-title" runat="server" id="titleRequestSlik">Report SLIK Result - Customer</h4>
                <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button> 
                </div>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-10">
                                <div class="form-group row">
                                    <div class="col-sm-4">Customer Name</div>
                                    <div class="col-sm-1">:</div>
                                    <div class="col-sm-7">
                                        <b>
                                            <label id="lblCustName" runat="server"></label>
                                        </b>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-4">Total Fasilitas / Aktif</div>
                                    <div class="col-sm-1">:</div>
                                    <div class="col-sm-7">
                                        <b>
                                            <label id="lblTotalFasilitasAktif" runat="server"></label>
                                        </b>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-4">Plafon Efektif / Baki Debet</div>
                                    <div class="col-sm-1">:</div>
                                    <div class="col-sm-7">
                                        <b>
                                            <label id="lblPlafonBakiDebet" runat="server"></label>
                                        </b>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-4">Policy Result</div>
                                    <div class="col-sm-1">:</div>
                                    <div class="col-sm-7">
                                        <asp:Label ForeColor="Red" Font-Bold="true" ID="final_policy" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-4">Export Data</div>
                                    <div class="col-sm-1">:</div>
                                    <div class="col-sm-4">
                                        <asp:DropDownList runat="server" ID="ExportType" CssClass="form-control form-control-sm" Style="width: 100%">
                                            <asp:ListItem Value="">(none)</asp:ListItem>
                                            <asp:ListItem Value="txt">Textfile</asp:ListItem>
                                            <asp:ListItem Value="pdf">PDF</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-sm-3">
                                        <asp:Button ID="BtnDownloadReport" OnClick="BtnDownloadReport_Click" CssClass="btn btn-sm btn-success"
                                            runat="server" Text="Download Report" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="divKontrakLunas" runat="server"></div>
                        <div id="divKontrakAktif" runat="server"></div>
                        <div id="divKontrakWO" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
        <div id="divLoopReport" runat="server"></div>
    </form>
</body>
</html>

