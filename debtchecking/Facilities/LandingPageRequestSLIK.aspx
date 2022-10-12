<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="LandingPageRequestSLIK.aspx.cs" Inherits="DebtChecking.Facilities.LandingPageRequestSLIK" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2" %>

<!DOCTYPE html>
<html>
<head>
    <title></title>
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">

                    <div class="card card-primary card-outline">
                        <div class="card-header">
                            <h4 class="card-title">Silakan Pilih Nasabah </h4>
                        </div>
                        <!-- /.card-header -->

                        <div class="card-body">
                            <div class="text-left">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <asp:LinkButton ID="INDIVIDU" runat="server" class="btn btn-sq-lg btn-success" OnClick="INDIVIDU_Click">
                                    <i class="fa fa-user fa-5x"></i>
                                    <br />
                                    Individu
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="PERUSAHAAN" runat="server" class="btn btn-sq-lg btn-danger" OnClick="PERUSAHAAN_Click">
                                    <i class="fa fa-building fa-5x"></i>
                                    <br />
                                    Perusahaan
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>