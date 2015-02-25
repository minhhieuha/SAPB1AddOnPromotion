<%@ Page  Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Company.aspx.cs" Inherits="PromotionEngine.Company" Title="Promotion Engine - Company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 
    <script type="text/javascript">
        var oCompany = {};
        var isInsert = false;
        $(document).ready(function () {
            GetCompanys();
        });
        function initCompany() {

            oCompany.CompanyCode = '';
            oCompany.CompanyName = '';
            oCompany.IsActive = false;
            oCompany.Address = '';
            oCompany.ContactPerson = "";
            oCompany.ContactPhone = "";

        }
        //Get All Company
        function GetCompanys() {
            $.ajax({
                type: "POST",
                url: "Company.aspx/GetCompanys",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        }
    </script>
    <script type="text/javascript">
       //Bind Data
        function OnSuccess(response) {
            var data = $.parseJSON(response.d);
            var grid = $("#grid").kendoGrid({
                dataSource: { data: data,
                    pageSize: 20,
                    schema: {
                        type: 'json',
                        model: {
                            id: "CompanyCode",
                            fields: {
                                CompanyCode: { type: "string", validation: { required: true} },
                                CompanyName: { type: "string", validation: { required: true} },
                                Address: { type: "string", validation: { required: true} },
                                ContactPerson: { type: "string", validation: { required: true} },
                                ContactPhone: { type: "string", validation: { required: true} },
                                IsActive: { type: "boolean" }
                            }
                        }
                    }
                },
                filterable: true,
                height: 500,
                sortable: true,
                toolbar: [{ name: 'create', text: 'Add New Company'}],
                pageable: true,
                batch: true,
                columns: [{ field: "CompanyCode", title: "Code", width: 100 },
                            { field: "CompanyName", title: "Name", width: 300 },
                            { field: "Address", title: "Address", width: 300 },
                            { field: "ContactPerson", title: "Contact Person" },
                            { field: "ContactPhone", title: "Contact Phone" },
                            { field: "IsActive", title: "Active", width: 70 },
                            { command: ["edit", "destroy"], title: "Action", width: "170px"}]
                , editable: {
                    mode: "popup",
                    confirmation: "Are you sure you want to remove this company?"
                },
                edit: function (e) {
                    var editWindow = e.container.data("kendoWindow");

                    if (e.model.isNew()) {
                        e.container.data("kendoWindow").title('Add New Company');
                        $("a.k-grid-update")[0].innerHTML = "<span class='k-icon k-update'></span>Save";
                        isInsert = true;
                        initCompany();
                    }
                    else {
                        e.container.data("kendoWindow").title('Edit Company');
                        $('[name="CompanyCode"]').attr("readonly", true);
                        isInsert = false;
                    }
                },
                remove: function (e) {
                    //alert("delete event captured");
                    //Do your logic here before delete the record.
                },
                save: function (e) {
                    var that = this;
                    var num = 1;
                    var listTextBox = $("input:text");
                    for (var i = 0; i < listTextBox.length; i++) {
                        var name = listTextBox[i].name;
                        oCompany[name] = $("[name=" + name + "]").val();

                    }
                    var listCheckBox = $("input:checkbox");
                    for (var i = 0; i < listCheckBox.length; i++) {
                        var name = listCheckBox[i].name;
                        if ($("[name=" + name + "]").is(':checked')) {
                            oCompany.IsActive = 'true';
                        }
                        else {
                            oCompany.IsActive = 'false';
                        }
                    }
                    //Update or Insert Company
                    $.ajax({
                        type: "POST",
                        url: "Company.aspx/UpdateCompany",
                        data: JSON.stringify({
                            oCompany: JSON.stringify(oCompany),
                            isInsert: isInsert
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                        //Reload Data 
                            if (isInsert) {
                                GetCompanys();
                            }
                        },
                        error: function (xhr, status, err) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.Message);
                        }
                    });
                }
            });
        };
    </script>
    <div style="position: absolute; z-index: 0;">
    <div id="grid">
    </div>
    </div>
</asp:Content>
