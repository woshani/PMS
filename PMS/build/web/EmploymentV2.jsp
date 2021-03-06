<%@page import="java.util.ArrayList"%>
<%@page import="Config.Config"%>
<%@page import="Config.connect"%>
<%@page import="dBConn.Conn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Conn conn = new Conn();
    String incomeRange = "select * from adm_lookup_detail where master_reference_code = '0028' ";
    String hcf = "select * from adm_lookup_detail where master_reference_code = '0081'   ";
    String status = "select * from adm_lookup_detail where master_reference_code = '0014'   ";
    String occupation = "select * from adm_lookup_detail where master_reference_code = '0050'";

    //String empList = "select * from pms_employment where pmi_no = ''";
    ArrayList<ArrayList<String>> dataIncomeRange, dataHfc, dataStatus,dataOccu;

    dataIncomeRange = conn.getData(incomeRange);
    dataHfc = conn.getData(hcf);
    dataStatus = conn.getData(status);
    dataOccu = conn.getData(occupation);


%>
<div class="row">
    <div class="col-md-12">
        <div class="thumbnail" id="maintainEMP">
            <h4>Employment Information</h4>
            <form class="form-horizontal" id="empform">

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">PMI No.</label>  
                    <div class="col-md-4">
                        <input id="EMPpmino" name="EMPpmino" type="text"  class="form-control input-md">
                        <input id="EMPseq" name="EMPseq" type="hidden"  class="form-control input-md">
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Employer Code</label>  
                    <div class="col-md-4">
                        <input id="EMPempcode" name="EMPempcode" type="text"  class="form-control input-md">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Employer Name</label>  
                    <div class="col-md-4">
                        <input id="EMPempname" name="EMPempname" type="text"  class="form-control input-md" maxlength="80">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Occupation</label>  
                    <div class="col-md-4">
<!--                        <input id="EMPoccu" name="EMPoccu" type="text"  class="form-control input-md">-->
                        <select id="EMPoccu" name="EMPoccu" class="form-control">
                            <option selected="" disabled="">Please select Occupation</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataOccu.size(); i++) {%>
                            <option value="<%=dataOccu.get(i).get(1)%>"><%=dataOccu.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Joined Date</label>  
                    <div class="col-md-4">
                        <input id="EMPjdate" name="EMPjdate" type="text"  class="form-control input-md">

                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="selectbasic">Income Range</label>
                    <div class="col-md-4">
                        <select id="EMPinrange" name="EMPinrange" class="form-control">
                            <option selected="" disabled="">Please select Income Range</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataIncomeRange.size(); i++) {%>
                            <option value="<%=dataIncomeRange.get(i).get(1)%>"><%=dataIncomeRange.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="selectbasic">Health Facility</label>
                    <div class="col-md-4">
                        <select id="EMPhfc" name="EMPhfc" class="form-control">
                            <option selected="" disabled="">Please select health facility</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataHfc.size(); i++) {%>
                            <option value="<%=dataHfc.get(i).get(1)%>"><%=dataHfc.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Created Date</label>  
                    <div class="col-md-4">
                        <input id="EMPcredate" name="EMPcredate" type="text"  class="form-control input-md" readonly>

                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="selectbasic">Status</label>
                    <div class="col-md-4">
                        <select id="EMPstatus" name="EMPstatus" class="form-control">
                            <option selected="" disabled="">Please select status</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataStatus.size(); i++) {%>
                            <option value="<%=dataStatus.get(i).get(1)%>"><%=dataStatus.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

            </form>
            <div class="text-center">
                <button id="EMPsave" name="EMPsave" class="btn btn-primary"><i class="fa fa-floppy-o fa-lg"></i>&nbsp; Save</button>
                <!--                <button id="EMPupdate" name="EMPupdate" class="btn btn-default" disabled=""><i class="fa fa-edit fa-lg"></i>&nbsp; Update</button>-->
                <button id="EMPclear" name="EMPclear" class="btn btn-default"><i class="fa fa-ban fa-lg"></i>&nbsp; Clear</button>
            </div>
        </div>

        <div class="thumbnail">
            <h4>List of Employments</h4>
            <div id="tableListEmp" class="form-group">
                
            
            <table class="table table-filter table-striped" style="background: #fff; border: 1px solid #ccc; " id="listEMP">
                <thead>
                <th>Employer Name</th>
                <th>Occupation</th>
                <th>Update</th>
                <th>Delete</th>
                </thead>
                <tbody>

                </tbody>
            </table>
             </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $(function(){
            $('#EMPcredate').datepicker({dateFormat:'dd-mm-yy',changeMonth:true,changeYear:true});
        });
        
        $(function(){
            $('#EMPjdate').datepicker({dateFormat:'dd-mm-yy',changeMonth:true,changeYear:true});
        });
        
    });
    //yyyy-MM-dd HH:mm:ss
    var nowDate = new Date();
    var ZeroMinutes, ZeroSeconds, ZeroDay, ZeroMonth;

    //months
    var month = (nowDate.getMonth() + 1);
    if (month < 10) {
        ZeroMonth = "0" + month;
    } else {
        ZeroMonth = month;
    }

    //days
    var day = (nowDate.getDate());
    if (day < 10) {
        ZeroDay = "0" + day;
    } else {
        ZeroDay = day;
    }

    //years
    var year = (nowDate.getFullYear());

    //hours
    var hours = nowDate.getHours();
    //minutes
    var minutes = nowDate.getMinutes();
    if (minutes < 10) {
        ZeroMinutes = "0" + minutes;
    } else {
        ZeroMinutes = minutes;
    }
    //seconds
    var seconds = nowDate.getSeconds();
    if (seconds < 10) {
        ZeroSeconds = "0" + seconds;
    } else {
        ZeroSeconds = seconds;
    }
    //complete day
    var yyyyMMddHHmmss = year + "-" + ZeroMonth + "-" + ZeroDay + " " + hours + ":" + ZeroMinutes + ":" + ZeroSeconds;
    var HHmmss = hours + ":" + ZeroMinutes + ":" + ZeroSeconds;
    var yyyyMMdd = year + "-" + ZeroMonth + "-" + ZeroDay;
    var ddMMyyyy= ZeroDay+ "-" + ZeroMonth + "-" +year;
    $('#EMPcredate').val(ddMMyyyy);
    //function to save employment when click save button
    $('#EMPsave').on('click', function () {

        var EMPpmino = $('#EMPpmino').val(),
                EMPseq = $('#EMPseq').val(),
                EMPcd = $('#EMPempcode').val(),
                EMPname = $('#EMPempname').val(),
                EMPoccu = $('#EMPoccu').val(),
                EMPjdate = $('#EMPjdate').val(),
                EMPinrange = $('#EMPinrange').val(),
                EMPhfc = $('#EMPhfc').val(),
                EMPcredate = $('#EMPcredate').val(),
                EMPstatus = $('#EMPstatus').val();

        var splitCreDate = String(EMPcredate).split("-");
        var convertedCreDate = splitCreDate[0] + "/" + splitCreDate[1] + "/" + splitCreDate[2];

        var splitJDate = String(EMPjdate).split("-");
        var convertedJDate = splitJDate[0] + "/" + splitJDate[1] + "/" + splitJDate[2];

        var datas = {
            EMPpmino: EMPpmino,
            EMPseq: EMPseq,
            EMPcd: EMPcd,
            EMPname: EMPname,
            EMPoccu: EMPoccu,
            EMPjdate: convertedJDate,
            EMPinrange: EMPinrange,
            EMPhfc: EMPhfc,
            EMPcredate: convertedCreDate,
            EMPstatus: EMPstatus
        };
        //console.log(datas);
        bootbox.confirm({
            message: "Are you sure want to save patient's Employment Information?",
            buttons: {
                confirm: {
                    label: 'Yes',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'No',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                //if true go to PMI page
                if (result === true) {
                    $.ajax({
                        type: "post",
                        url: "saveEmp.jsp",
                        data: datas,
                        timeout: 3000,
                        success: function (data) {
                            console.log(data);
                            if (data.trim() === "true") {
                                bootbox.alert('Patient Employment Information  saved successfully');
                                $('#empform')[0].reset();
                                $('input[id=EMPpmino]').val($.trim(EMPpmino));
                                //$('#empform').find('input, select, textarea').not("#EMPpmino").val('');
                                //$('select').find('option').prop("selected", false);
                                $.ajax({
                                    url: "listEmp.jsp",
                                    type: "post",
                                    data: {'PMINO': EMPpmino},
                                    timeout: 3000,
                                    success: function (returnhtml) {
                                        console.log(returnhtml);
                                        $('#tableListEmp').html(returnhtml);
                                        $('#EMPpmino').prop('readonly', false);
                                    }
                                });
                            } else {
                                bootbox.alert('Patient Employment Information  fail to save');
                            }

                        }, error: function () {

                        }

                    });
                }
            }
        });


    });

    //function to clear the form when click clear button
    $('#EMPclear').on('click', function () {
        var pmino = $('input[id=EMPpmino]').val();
        $('#empform')[0].reset();
        $('input[id=EMPpmino]').val(pmino);
        $('#EMPseq').val("");
        $('#EMPpmino').prop('readonly', false);
    });

    //function to edit employment data from table
    $('#tableListEmp').on('click', '#listEMP #EMPedit', function (e) {
        //prevent any default function
        e.preventDefault();
        
        $('#EMPpmino').prop('readonly', true);
        
        //go to the top
        $('html,body').animate({
            scrollTop: $("#maintainEMP").offset().top
        }, 500);
        //get the row value
        var row = $(this).closest("tr");
        var rowData = row.find("#empval").val();
        var arrayData = rowData.split("|");
        //assign into seprated val
        var pmino = arrayData[0], seqno = arrayData[1], empcode = arrayData[2], empname = arrayData[3], occu = arrayData[4], jdate = arrayData[5], incomerange = arrayData[6], hfc = arrayData[7], credate = arrayData[8], empstatus = arrayData[9];
        //convert date
        var splitCreDate = String(credate).split("/");
        var convertedCreDate = splitCreDate[0] + "-" + splitCreDate[1] + "-" + splitCreDate[2];

        var splitJDate = String(jdate).split("/");
        var convertedJDate = splitJDate[0] + "-" + splitJDate[1] + "-" + splitJDate[2];
//        console.log(convertedCreDate);
//        console.log(convertedJDate);

        $('#EMPpmino').val(pmino);
        $('#EMPempcode').val(empcode);
        $('#EMPempname').val(empname);
        $('#EMPoccu').val(occu);
        $('#EMPjdate').val(convertedJDate);
        $('#EMPinrange').val(incomerange);
        $('#EMPhfc').val(hfc);
        $('#EMPcredate').val(convertedCreDate);
        $('#EMPstatus').val(empstatus);
        $('#EMPseq').val(seqno);

        console.log(arrayData);
    });


    $('#tableListEmp').on('click', '#listEMP #EMPdel', function (e) {
        e.preventDefault();
        var row2 = $(this).closest("tr");
        var rowData2 = row2.find("#empval").val();
        
        console.log(rowData2);
        bootbox.confirm({
            message: "Are you sure want to delete patient's Employment Information?",
            buttons: {
                confirm: {
                    label: 'Yes',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'No',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                
                if (result === true) {
                    //get the row value
                    row2.remove();
                    var arrayData2 = rowData2.split("|");
                    //assign into seprated val
                    var pmino = arrayData2[0], seqno = arrayData2[1];
                    var datas = {pmino:pmino,seqno:seqno};
                    console.log(datas);
                    $.ajax({
                        type: "post",
                        url: "delEmp.jsp",
                        data: datas,
                        timeout: 3000,
                        success: function (data) {
                            console.log(data);


                        }, error: function () {

                        }

                    });
                }
            }
        });
    });

</script>