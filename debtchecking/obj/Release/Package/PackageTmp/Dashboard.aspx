<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="DebtChecking.Dashboard" %>

<!DOCTYPE html>
<html>
<head>
    <title>EDIS</title>
    <Template:Admin runat="server" ID="Template" />
    <script src="include/dashboard.js"></script>
</head>
<body>
    <div class="container-fluid">
        <input type="hidden" name="api_url" id="api_url" runat="server" />
        <input type="hidden" name="pbMonthly" id="valMonth" runat="server" value="98" />
        <input type="hidden" name="pbToday" id="valToday" runat="server" value="91" />
        <!-- Small boxes (Stat box) -->
        <div class="row">
            <!-- ./col -->
            <div class="col-lg-4">
                <!-- small box -->
                <div class="small-box bg-success">
                    <div class="inner">
                        <h3 id="monthIncoming">0</h3>
                        <p>This Month's Incoming</p>
                        <div class="form-group row">
                            <div class="col-sm-9 pt-1">
                                <div class="progress">
                                    <div id="pbMonth" class="progress-bar bg-info progress-bar-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                        <span class="sr-only">98% Complete (success)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <h5 id="monthIncomingPercent">98%</h5>
                            </div>
                        </div>
                    </div>
                    <div class="icon text-light">
                        <i class="ion ion-stats-bars"></i>
                    </div>
                </div>
                <!-- small box -->
            </div>
            <!-- ./col -->
            <div class="col-lg-4">
                <!-- small box -->
                <div class="small-box bg-info">
                    <div class="inner">
                        <h3 id="todayIncoming">0</h3>
                        <p>Today's Incoming</p>
                        <div class="form-group row">
                            <div class="col-sm-9 pt-1">
                                <div class="progress">
                                    <div id="pbToday" class="progress-bar bg-success progress-bar-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                        <span class="sr-only">40% Complete (success)</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <h5 id="todayIncomingPercent">91%</h5>
                            </div>
                        </div>
                    </div>
                    <div class="icon text-light">
                        <i class="ion ion-stats-bars"></i>
                    </div>
                </div>
                <!-- small box -->
            </div>
            <!-- ./col -->
            <div class="col-lg-4">
                <!-- small box -->
                <div class="small-box bg-primary">
                    <div class="inner">
                        <div class="row">
                            <div class="col-sm-9">Final Status</div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <canvas id="chartSummaryStatus" style="width: 125px !important; height: 105px !important"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- small box -->
            </div>
            <!-- ./col -->
        </div>
        <!-- Small boxes (Stat box) -->
        <div class="row">
            <div class="col-sm-12">
                <div class="box">
                    <div class="row">
                        <div class="col-sm-7">
                            <div class="card card-primary card-outline" style="min-height: 310px !important">

                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-sm-8 pt-1">
                                            <h3 class="card-title">
                                                <i class="fas fa-chart-pie"></i>
                                                Final Status
                                            </h3>
                                        </div>
                                        <div class="col-sm-4 text-right" id="filterContainer">
                                            <select id="filterDashboard" class="form-control-sm">
                                                <option value="summaryStatusDaily">Daily</option>
                                                <option value="summaryStatusMonthly">Monthly</option>
                                            </select>
                                            <%--iki di iisi seko API ne--%>
                                            <select id="filterYear" class="form-control-sm">
                                            </select>
                                            <%--muhamaaad winndy ssuuuuulistiyo--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" id="graph-container">
                                    <canvas id="chartFinalStatus" style="width: 200px !important; height: 225px !important"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="card card-primary card-outline" style="min-height: 310px !important">
                                <div class="card-body">
                                    <%--table e ngko di isi ko api wae - muhamad windy sulistiyo--%>
                                    <table id="tblMonthlyIncoming" class="table table-sm border-bottom">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>