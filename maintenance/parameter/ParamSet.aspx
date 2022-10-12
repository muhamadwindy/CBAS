<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParamSet.aspx.cs" Inherits="MikroMnt.Parameter.ParamSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ParamSet Page</title>
    <link href="../include/style.css" type="text/css" rel="stylesheet" />
    <Template:Admin runat="server" ID="Template" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <h5 class="mb-2 text-center">
                        <asp:Label ID="LBL_TITLE" runat="server"></asp:Label>
                    </h5>

                </div>

            </div>
            <div class="row">
                <div class="col-sm-12">
                    <dx:ASPxDataView ID="dataView" runat="server" OnLoad="dataView_Load" Theme="MaterialCompact">
                        <ItemTemplate>

                            <div class="info-box text-sm">
                                <span class="info-box-icon bg-info"><i class="fa fa-cogs"></i></span>
                                <div class="info-box-content">
                                    <span class="info-box-text">
                                        <asp:HyperLink ID="lnk" runat="server" Text='<%# Eval("PARAMDESC") %>' NavigateUrl='<%# Eval("PARAMLINK") %>'>
                                        </asp:HyperLink>
                                    </span>
                                </div>
                                <!-- /.info-box-content -->
                            </div>
                        </ItemTemplate>
                        <PagerSettings>
                            <AllButton Visible="True"></AllButton>
                        </PagerSettings>
                    </dx:ASPxDataView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
