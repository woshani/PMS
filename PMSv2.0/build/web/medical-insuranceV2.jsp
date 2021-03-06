<%@page import="dBConn.Conn"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Config.connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Conn conn = new Conn();
    //String relation = "select * from lookup_detail where master_ref_code = '0007' order by Description";
    String hcf = "select * from adm_lookup_detail where master_reference_code = '0081'   ";
    String insuranceCompany = "select * from adm_lookup_detail where master_reference_code = '0083'   ";
    String insurancePolicy = "select * from adm_lookup_detail where master_reference_code = '0058'   ";
    ArrayList<ArrayList<String>> dataHfc, dataInsurancePolicy, dataInsuranceCompany;
    dataHfc = conn.getData(hcf);
    dataInsurancePolicy = conn.getData(insurancePolicy);
    dataInsuranceCompany = conn.getData(insuranceCompany);

%>			
<div class="row">
    <div class="col-md-12">
        <div class="thumbnail" id="maintainMED">
            <h4>Medical Insurance Information</h4>
            <form class="form-horizontal" id="formMed">

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">PMI No.</label>
                    <div class="col-md-4">
                        <input id="MEDpmino" name="MEDpmino" type="text"  class="form-control input-md">
                        <input id="MEDseq" name="MEDseq" type="hidden"  class="form-control input-md">
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="selectbasic">Insurance Company</label>
                    <div class="col-md-4">
                        <select id="MEDinscom" name="MEDinscom" class="form-control">
                            <option value="1">Please Select Insurance Company</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataInsuranceCompany.size(); i++) {%>
                            <option value="<%=dataInsuranceCompany.get(i).get(1)%>"><%=dataInsuranceCompany.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Policy No.</label>  
                    <div class="col-md-4">
                        <input id="MEDpolicy" name="MEDpolicy" type="text"  class="form-control input-md" maxlength="15">

                    </div>
                </div>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="textinput">Maturity Date</label>  
                    <div class="col-md-4">
                        <input id="MEDdate" name="MEDdate" type="text"  class="form-control input-md">

                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="selectbasic">Health Facility</label>
                    <div class="col-md-4">
                        <select id="MEDhfc" name="MEDhfc" class="form-control">
                            <option selected="" disabled="">Please select health facility</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataHfc.size(); i++) {%>
                            <option value="<%=dataHfc.get(i).get(1)%>"><%=dataHfc.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

                <!-- Select Basic -->
                <div class="form-group">
                    <label class="col-md-4 control-label" for="selectbasic">Policy Status</label>
                    <div class="col-md-4">
                        <select id="MEDstatus" name="MEDstatus" class="form-control">
                            <option value="null" selected="" disabled="">Please Select Policy Status</option>
                            <option value="-">-</option>
                            <% for (int i = 0; i < dataInsurancePolicy.size(); i++) {%>
                            <option value="<%=dataInsurancePolicy.get(i).get(1)%>"><%=dataInsurancePolicy.get(i).get(2)%></option>
                            <%  }
                            %>
                        </select>
                    </div>
                </div>

            </form>
            <div class="text-center">
                <button id="MEDsave" name="MEDsave" class="btn btn-primary"><i class="fa fa-floppy-o fa-lg"></i>&nbsp; Save</button>
                <button id="MEDclear" name="MEDclear" class="btn btn-default"><i class="fa fa-ban fa-lg"></i>&nbsp; Clear</button>
            </div>
        </div>

        <div class="thumbnail">
            <h4>List of Medical Insurance</h4>
            <div id="tableListMed" class="form-group">
                <table class="table table-filter table-striped" style="background: #fff; border: 1px solid #ccc; " id="listMED">
                    <thead>
                    <th>Insurance Company</th>
                    <th>Policy No.</th>
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
    $(document).ready(function () {
        $(function () {
            $('#MEDdate').datepicker({dateFormat: 'dd-mm-yy',changeMonth:true,changeYear:true});
        });
    });
    $('#MEDsave').on('click', function (e) {
        e.preventDefault();
        var pmino = $('#MEDpmino').val(),
                insuranceCom = $('#MEDinscom').val(),
                policy = $('#MEDpolicy').val(),
                maturityDate = $('#MEDdate').val(),
                hfc = $('#MEDhfc').val(),
                status = $('#MEDstatus').val(),
                seq = $('#MEDseq').val();

        if (insuranceCom === null) {
            insuranceCom = "-";
        }
        if (policy === "") {
            policy = "-";
        }
        if (hfc === null) {
            hfc = "-";
        }
        if (status === null) {
            status = "-";
        }
        if (maturityDate === null) {
            maturityDate = "-";
        } else {
            var splitmaturitydate = String(maturityDate).split("-");
            var convertedmaturitydate = splitmaturitydate[2] + "/" + splitmaturitydate[1] + "/" + splitmaturitydate[0];
        }


        var datas = {
            pmino: pmino,
            insuranceCom: insuranceCom,
            policy: policy,
            maturityDate: convertedmaturitydate,
            hfc: hfc,
            status: status,
            seq: seq
        };



        bootbox.confirm({
            message: "Are you sure want to save patient's Medical Information?",
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
                        url: "saveMedical.jsp",
                        data: datas,
                        timeout: 3000,
                        success: function (data) {
                            console.log(data);
                            if (data.trim() === "true") {
                                bootbox.alert("Patient's Medical Information saved successfully");
                                $('#formMed')[0].reset();
                                $('input[id=MEDpmino]').val(pmino);

                                $.ajax({
                                    url: "listMedical.jsp",
                                    type: "post",
                                    data: {'PMINO': pmino},
                                    timeout: 3000,
                                    success: function (returnhtml) {
                                        //console.log(returnhtml);
                                        $('#tableListMed').html(returnhtml);
                                        $('#MEDpmino').prop('readonly', false);
                                        $('#MEDpolicy').prop('readonly', false);
                                    }
                                });
                            } else {
                                bootbox.alert("Patient's Medical Information  fail to save");
                            }

                        }, error: function () {

                        }

                    });
                }
            }
        });
    });
    $('#MEDclear').on('click', function () {
        var pmino = $('#MEDpmino').val();
        $('#formMed')[0].reset();
        $('#MEDpmino').val(pmino);
        $('#MEDseq').val("");
        $('#MEDpmino').prop('readonly', false);
        $('#MEDpolicy').prop('readonly', false);
    });

    //function to edit next of kin data from table
    $('#tableListMed').on('click', '#listMED #MEDedit', function (e) {
        e.preventDefault();
        $('#MEDpmino').prop('readonly', true);
        $('#MEDpolicy').prop('readonly', true);
        //go to the top
        $('html,body').animate({
            scrollTop: $("#maintainMED").offset().top
        }, 500);

        //get the row value
        var row = $(this).closest("tr");
        var rowData = row.find("#medval").val();
        var arrayData = rowData.split("|");
        //assign into seprated val
        var pmino = arrayData[0], insuran = arrayData[1], policy = arrayData[2], maturitydate = arrayData[3], hfc = arrayData[4], status = arrayData[5];
        //convert date
        var splitmaturitydate = String(maturitydate).split("/");
        var convertedmaturitydate = splitmaturitydate[0] + "-" + splitmaturitydate[1] + "-" + splitmaturitydate[2];

        $('#MEDpmino').val(pmino);
        $('#MEDinscom').val(insuran);
        $('#MEDpolicy').val(policy);
        $('#MEDdate').val(convertedmaturitydate);
        $('#MEDhfc').val(hfc);
        $('#MEDstatus').val(status);

        console.log(convertedmaturitydate);
        console.log(arrayData);
    });
    
    //delete function when click delete on next of kin
    $('#tableListMed').on('click', '#listMED #MEDdel', function (e) {
        e.preventDefault();
        var row2 = $(this).closest("tr");
        var rowData2 = row2.find("#medval").val();

        console.log(rowData2);
        bootbox.confirm({
            message: "Are you sure want to delete patient's Medical Insurance?",
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
                    var pmino = arrayData2[0], policy = arrayData2[2];
                    var datas = {pmino: pmino, policy : policy};
                    console.log(datas);
                    $.ajax({
                        type: "post",
                        url: "delMedical.jsp",
                        data: datas,
                        timeout: 3000,
                        success: function (data) {
                            console.log("delete " + data);


                        }, error: function () {

                        }

                    });
                }
            }
        });
    });
</script>