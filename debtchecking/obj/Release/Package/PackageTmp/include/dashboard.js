/*!
 * Iki Gawe Ngehandle Dashboard
 * gaweane muhamad windy sulistiyo
 * 26/2/2020
 * Sombong dhisik perkoro mlarat keri
 * Ojo wedi kere, penting sudih atine
 * Ojo Dumeh
 * Licensed under the Under Wear v2.0 (https://www.xvideos.com)
 */




$(document).ready(function () {

    var isIE = /*@cc_on!@*/false || !!document.documentMode;
    if (isIE) {
        $('#chartSummaryStatus').attr('style', 'width: 330px !important; height: 105px !important');
    }
    function getRandomColor() {
        if (isIE) {
            var r = Math.floor(Math.random() * 255) - 1;
            var g = Math.floor(Math.random() * 255) - 1;
            var b = Math.floor(Math.random() * 255) - 1;
            return "rgb(" + r + "," + g + "," + b + ")";
        } else {

            var r = Math.floor(Math.random() * 255);
            var g = Math.floor(Math.random() * 255);
            var b = Math.floor(Math.random() * 255);
            return "rgba(" + r + "," + g + "," + b + ")";
        }
    }


    var api_url = $('#api_url').val() + '/getdatadashboard';
    var userID = "admin";
    var tipeDataneOpo = 'jsonp';

    function generateFilterYear() {
        $.ajax({
            url: api_url,
            contentType: "application/json",
            dataType: tipeDataneOpo,
            headers: { 'Access-Control-Allow-Origin': '*' },
            type: "GET",
            data: {
                "type": "listHistoricalYear",
                "userid": userID
            },
            success: function (result) {
                var filterYear = $('#filterYear');
                filterYear.empty();
                for (var i = 0; i < result.year.length; i++) {
                    var d = document;
                    //kene iki ge ngeload data tahun e seko SP - mhd wiiiindy suuullisttiyoo
                    var option = d.createElement("option");
                    $(option).attr('value', result.year[i]);
                    option.innerHTML = result.year[i];
                    $(filterYear).append(option);
                }
            }
        });
    }

    generateFilterYear();

    //================= catetane windy sulistiyo mulai
    //mulai=============iki gawe sing ngisi This Month's Incoming karo Today's Incoming
    $.ajax({
        url: api_url,
        contentType: "application/json",
        dataType: tipeDataneOpo,
        headers: { 'Access-Control-Allow-Origin': '*' },
        type: "GET",
        data: {
            "type": "incoming",
            "userid": userID
        },
        success: function (result) {
            //console.log(result);
            //debugger

            if (result.responseCode == "1") {
                var val_month = result.monthIncoming;
                var val_month_percent = result.monthIncomingPercent;
                var val_today = result.todayIncoming;
                var val_today_percent = result.todayIncomingPercent;

                $('#monthIncoming').text(val_month);
                $('#monthIncomingPercent').text(val_month_percent + '%');
                $('#todayIncoming').text(val_today);
                $('#todayIncomingPercent').text(val_today_percent + '%');

                $('#pbMonth').css('width', val_month_percent + '%');
                $('#pbMonth').attr('aria-valuenow', val_month_percent + '%');

                $('#pbToday').css('width', val_today_percent + '%');
                $('#pbToday').attr('aria-valuenow', val_today_percent + '%');
            }
        },
        error: function (result) {
            alert('Error Get Data Dashboard');
        }
    });
    //rampung===========iki gawe sing ngisi This Month's Incoming karo Today's Incoming

    //mulai=============iki gawe sing ngisi Final Status
    $.ajax({
        url: api_url,
        contentType: "application/json",
        dataType: tipeDataneOpo,
        headers: { 'Access-Control-Allow-Origin': '*' },
        type: "GET",
        data: {
            "type": "summaryStatusTodayIncoming",
            "userid": userID
        },
        success: function (result) {
            var labelsSummaryStatus = result.status;
            var dataSummaryStatus = result.numberOfRequest;
            var bgcolor = [getRandomColor(), getRandomColor(), getRandomColor(), getRandomColor(), getRandomColor(), getRandomColor(), getRandomColor()];
            var pie = document.getElementById("chartSummaryStatus").getContext('2d');
            var temp = new Chart(pie, {
                type: 'doughnut',
                data: {
                    labels: labelsSummaryStatus,
                    datasets: [
                        {
                            data: dataSummaryStatus,
                            backgroundColor: bgcolor,
                            borderWidth: 1
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    title: {
                        display: false,
                        text: "Final Status",
                        fontColor: "White"
                    },
                    legend: {
                        position: "right",
                        align: "top",
                        fontColor: "White",
                        labels: {
                            fontColor: "white"
                        }
                    }
                }
            });

            //$("#chartSummaryStatus").click(
            //    function (evt) {
            //        var activePoints = temp.getElementsAtEvent(evt);
            //        var URL = "http://example.com/?label=" + activePoints[0]._model.label + "&value=" + result.numberOfRequest[activePoints[0]._index];
            //        // alert(URL);
            //        var strWindowFeatures = "location=yes,height=570,width=1024,scrollbars=yes,status=false";
            //        window.open(result.urlDetail[activePoints[0]._index], "_blank", strWindowFeatures);
            //        //window.open(URL, "_blank", strWindowFeatures);
            //    }
            //);
        },
        error: function (result) {
            alert('Error Get Data Dashboard');
        }
    });
    //rampung===========iki gawe sing ngisi Final Status

    //mulai=============iki gawe sing ngisi
    //iki pas ngelot pertamane - wiindy suliiisttiyyo
    generateFinalStatus($("#filterDashboard").val());
    $(function () {
        //iki rodok mumet zone kene iki nggon jeroane, leh ku nggawe karo mumet - muhamad wwinndy suulistiyo
        $("#filterDashboard").on('change', function () {
            generateFinalStatus($("#filterDashboard").val());
        })
        $("#filterYear").on('change', function () {
            generateFinalStatus($("#filterDashboard").val());
        })
    });
    function generateFinalStatus(param) {
        var dataToday = { "type": param, "userid": userID };
        var dataMonthly = { "type": param, "userid": userID, "year": $("#filterYear").val() };
        var tempData = null;
        if (param == 'summaryStatusDaily') {
            tempData = dataToday;
            $("#filterYear").attr('style', 'display:none');
        } else {
            tempData = dataMonthly;
            $("#filterYear").removeAttr('style');
        }

        $.ajax({
            url: api_url,
            contentType: "application/json",
            dataType: tipeDataneOpo,
            headers: { 'Access-Control-Allow-Origin': '*' },
            type: "GET",
            data: tempData,
            success: function (result) {
                var labelFinalStatus = result.date;
                var dataFinalStatus = result.statusPerDate;
                $('#chartFinalStatus').remove(); // windy- sulistiyo - iki ge ngguwak terus di gawe meneh - muhamad windy sulistiyo
                var isIE = /*@cc_on!@*/false || !!document.documentMode;
                if (isIE) {
                    $('#graph-container').append('<canvas id="chartFinalStatus" style="width: 500px !important; height: 225px !important"></canvas>');
                } else {
                    $('#graph-container').append('<canvas id="chartFinalStatus" style="width: 200px !important; height: 225px !important"></canvas>');
                }

                var ctx = document.getElementById('chartFinalStatus').getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labelFinalStatus,
                        datasets: dataFinalStatus
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            xAxes: [{
                                stacked: true
                            }],
                            yAxes: [{
                                stacked: true,
                                scaleLabel: {
                                    display: false,
                                    labelString: 'Task Count'
                                }
                            }]
                        },
                        legend: {
                            position: "bottom",
                            align: "top",
                            fontColor: "White",
                        },
                    }
                });
            },
            error: function (result) {
                alert('Error Get Data Dashboard');
            }
        });
    }
    //rampung===========iki gawe sing ngisi

    //mulai=============iki gawe sing ngisi Pojok Tengen Ngisor
    $.ajax({
        url: api_url,
        contentType: "application/json",
        dataType: tipeDataneOpo,
        headers: { 'Access-Control-Allow-Origin': '*' },
        type: "GET",
        data: {
            "type": "summaryStatusMonthIncoming",
            "userid": userID
        },
        success: function (result) {
            var tblMonthlyIncoming = $('#tblMonthlyIncoming');

            for (var i = 0; i < result.status.length; i++) {
                var d = document;
                //kene iki ge nggawe isi tabel sing metu tulisane pass a opo b tekan penring kui lo - muhamad windy sulistiyo
                var tr = d.createElement("tr");

                var tdLabel = d.createElement("td");
                tdLabel.innerHTML = result.status[i];

                var tdTitikLoro = d.createElement("td");
                tdTitikLoro.innerHTML = ":";

                var tdIsine = d.createElement("td");
                var ngelink = d.createElement("a");
                $(ngelink).attr('href', result.urlDetail[i]);
                ngelink.innerHTML = result.numberOfRequest[i];
                //rasah di woco penting mlaku ya - muhamad windy sulistiyo
                tdIsine.appendChild(ngelink);
                tr.appendChild(tdLabel);
                tr.appendChild(tdTitikLoro);
                tr.appendChild(tdIsine);
                tblMonthlyIncoming.append(tr);
            }
        },
        error: function (result) {
            //alert('Error Mbok Luweh'); //windy sulistiyo
        }
    });
    //rampung===========iki gawe sing ngisi Pojok Tengen Ngisor
    //================= catetane windy sulistiyo rampung

    //iki ben rodo munggah sitik, tampilan tok
    //DOMSettableTokenList
    $('.mb-2').remove();
});