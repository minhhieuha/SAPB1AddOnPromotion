<%@ Page Title="Promotion Engine -  Customer" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="PromotionEngine.Customer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var oCustomer = {};
        var isInsert = false;
        var jsonCompany = {}
        $(document).ready(function () {
            GetCompanys();
            GetCustomers();
        });
        //Get All Customer
        function GetCustomers() {
            $.ajax({
                type: "POST",
                url: "Customer.aspx/GetCustomers",
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
        //Get All Company
        function GetCompanys() {
            $.ajax({
                type: "POST",
                url: "Customer.aspx/GetCompanys",
                data: '',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    jsonCompany = $.parseJSON(data.d)
                },
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
                            id: "CustomerID",
                            fields: {
                                CustomerID: { type: "string", validation: { required: true} },
                                CustomerCode: { type: "string", validation: { required: true} },
                                CustomerName: { type: "string", validation: { required: true} },
                                CompanyCode: { type: "string", validation: { required: true} },
                                CreatedUserID: { type: "string", validation: { required: true} },
                                CreatedDate: { type: "date", validation: { required: true} },
                                BillingAddress: { type: "string", validation: { required: true} },
                                ShippingAddress: { type: "string", validation: { required: true} },
                                ContactPerson: { type: "string", validation: { required: true} },
                                PhoneNumber: { type: "string", validation: { required: true} },
                                Email: { type: "string", validation: { required: true} },
                                IsActive: { type: "boolean" }
                            }
                        }
                    }
                },
                filterable: true,
                height: 500,
                sortable: true,
                toolbar: [{ name: 'create', text: 'Add New Customer'}],
                pageable: true,
                batch: true,
                columns: [{ field: "CustomerID", title: "ID", width: 80, hidden: true },
                            { field: "CustomerCode", title: "Code", width: 100 },
                            { field: "CustomerName", title: "Name", width: 200 },
                            { field: "CompanyCode", title: "Company Code", hidden: true },
                            { field: "CompanyName", title: "Company Name", width: 200 },
                            { field: "ContactPerson", title: "Contact Person", width: 200 },
                            { field: "PhoneNumber", title: "Phone", width: 100 },
                            { field: "Email", title: "Email", width: 200 },
                            { field: "CreatedUserID", title: "Created User", hidden: true },
                            { field: "CreatedDate", title: "Created Date", format: "{0:MM/dd/yyyy}", hidden: true },
                            { field: "BillingAddress", title: "Billing Address", width: 80 },
                            { field: "ShippingAddress", title: "Shipping Address", width: 80 },
                            { field: "IsActive", title: "Active", width: 70 },
                            { command: ["edit", "destroy"], title: "Action", width: "170px"}]
                , editable: {
                    mode: "popup",
                    template: $("#template").html(),
                    confirmation: "Are you sure you want to remove this customer?"

                },
                edit: function (e) {
                    $('#ddlCompany').kendoDropDownList({
                        optionLabel: "[Select Company]",
                        dataTextField: "CompanyName",
                        dataValueField: "CompanyCode",
                        dataSource: {
                            data: jsonCompany
                        }
                    });
                    var editWindow = e.container.data("kendoWindow");

                    if (e.model.isNew()) {
                        e.container.data("kendoWindow").title('Add New Customer');
                        $("a.k-grid-update")[0].innerHTML = "<span class='k-icon k-update'></span>Save";
                        isInsert = true;
                    }
                    else {
                        e.container.data("kendoWindow").title('Edit Customer');
                        $('[name="CustomerID"]').attr("readonly", true);
                        $('[name="CustomerCode"]').attr("readonly", true);
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
                        oCustomer[name] = $("[name=" + name + "]").val();

                    }
                    var listCheckBox = $("input:checkbox");
                    for (var i = 0; i < listCheckBox.length; i++) {
                        var name = listCheckBox[i].name;
                        if ($("[name=" + name + "]").is(':checked')) {
                            oCustomer.IsActive = 'true';
                        }
                        else {
                            oCustomer.IsActive = 'false';
                        }
                    }
                    oCustomer.Email = $("[name=Email]").val();
                    oCustomer.CompanyCode = $("#ddlCompany").val();
                    //Update or Insert Customer
                    $.ajax({
                        type: "POST",
                        url: "Customer.aspx/UpdateCustomer",
                        data: JSON.stringify({
                            oCustomer: JSON.stringify(oCustomer),
                            isInsert: isInsert
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            GetCustomers();
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
    <script type="text/x-kendo-template" id="template">  
    <div  style="width:400px;">
        <div class="k-edit-label" style="display:none;">
            <label for="CustomerID">
                ID</label></div>
        <div class="k-edit-field" data-container-for="CustomerID"  style="display:none;">
            <input name="CustomerID" class="k-input k-textbox" type="text" readonly="readonly"
                data-bind="value:CustomerID"></div>
        <div class="k-edit-label">
            <label for="CustomerCode">
                Code</label></div>
        <div class="k-edit-field" data-container-for="CustomerCode">
            <input name="CustomerCode" class="k-input k-textbox" required="required" type="text"
                data-bind="value:CustomerCode"></div>
        <div class="k-edit-label">
            <label for="CustomerName">
                Name</label></div>
        <div class="k-edit-field" data-container-for="CustomerName">
            <input name="CustomerName" class="k-input k-textbox" required="required" type="text"
                data-bind="value:CustomerName"></div>
        <div class="k-edit-label">
            <label for="CompanyCode">
                Company</label></div>
        <div data-container-for="CompanyCode" class="k-edit-field">
         <input id="ddlCompany" data-bind="value:CompanyCode" required="required" validationMessage = "Company is required")>
        </div>
        <div class="k-edit-label">
            <label for="BillingAddress">
                Billing Address</label></div>
        <div class="k-edit-field" data-container-for="BillingAddress">
            <input name="BillingAddress" class="k-input k-textbox" required="required" type="text"
                data-bind="value:BillingAddress"></div>
        <div class="k-edit-label">
            <label for="ShippingAddress">
                Shipping Address</label></div>
        <div class="k-edit-field" data-container-for="ShippingAddress">
            <input name="ShippingAddress" class="k-input k-textbox" required="required" type="text"
                data-bind="value:ShippingAddress"></div>
        <div class="k-edit-label">
            <label for="ContactPerson">
                Contact Person</label></div>
        <div class="k-edit-field" data-container-for="ContactPerson">
            <input name="ContactPerson" class="k-input k-textbox" required="required" type="text"
                data-bind="value:ContactPerson"></div>
        <div class="k-edit-label">
            <label for="PhoneNumber">
                Contact Phone</label></div>
        <div class="k-edit-field" data-container-for="PhoneNumber">
            <input name="PhoneNumber" class="k-input k-textbox" required="required" type="text"
                data-bind="value:PhoneNumber"></div>
        <div class="k-edit-label">
            <label for="Email">
                Email</label></div>
        <div class="k-edit-field" data-container-for="Email">
            <input name="Email" class="k-input k-textbox" required="required" type="email" data-bind="value:Email"></div>
        <div class="k-edit-label">
            <label for="IsActive">
                Active</label></div>
        <div class="k-edit-field" data-container-for="IsActive">
            <input name="IsActive" type="checkbox" data-bind="checked:IsActive" data-type="boolean"></div>
    </div>

    </script>
    <div style="position: absolute; z-index: 0;">
        <div id="grid">
        </div>
    </div>
</asp:Content>
