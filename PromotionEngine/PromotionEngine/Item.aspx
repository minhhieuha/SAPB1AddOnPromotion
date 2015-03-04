<%@ Page Title="Promotion Engine - Item Master Data" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Item.aspx.cs" Inherits="PromotionEngine.Item" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        var oItem = {};
        var isInsert = false;
        var jsonCompany = {}
        $(document).ready(function () {

            GetCompanys();
            GetItems();
        });
        //Get All Item
        function GetItems() {
            $.ajax({
                type: "POST",
                url: "Item.aspx/GetItems",
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
                url: "Item.aspx/GetCompanys",
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
                            id: "ItemID",
                            fields: {
                                ItemID: { type: "string", validation: { required: true} },
                                ItemCode: { type: "string", validation: { required: true} },
                                ItemName: { type: "string", validation: { required: true} },
                                CompanyCode: { type: "string", validation: { required: true} },
                                CreatedUserID: { type: "string", validation: { required: true} },
                                CreatedDate: { type: "date", validation: { required: true} },
                                BasePrice: { type: "number", validation: { required: true,min: 0} },
                                AllowPromotion: { type: "boolean" },
                                IsActive: { type: "boolean" }
                            }
                        }
                    }
                },
                filterable: true,
                height: 500,
                sortable: true,
                toolbar: [{ name: 'create', text: 'Add New Item'},{name:'excel'}],
                  excel: {
                    fileName: "Item List.xlsx",
                    filterable: true
                },
                pageable: true,
                batch: true,
                columns: [{ field: "ItemID", title: "ID", width: 80, hidden: true },
                            { field: "ItemCode", title: "Code", width: 100 },
                            { field: "ItemName", title: "Name" },
                            { field: "CompanyCode", title: "Company Code", hidden: true },
                            <%if (bool.Parse(HttpContext.Current.Session["IsAdmin"].ToString())){%>
                            { field: "CompanyName", title: "Company Name", width: 300},
                            <%} else{ %>
                             {field: "CompanyName", title: "Company Name", width: 200, hidden: true},
                            <%} %>
                            { field: "BasePrice", title: "Price", width: 200, format: "{0:c}",type:"number", attributes: { style: "text-align:right;"} },
                            { field: "CreatedUserID", title: "Created User", hidden: true },
                            { field: "CreatedDate", title: "Created Date", format: "{0:MM/dd/yyyy}", hidden: true },
                            { field: "AllowPromotion", title: "AllowPromotion", width: 200 },
                            { field: "IsActive", title: "Active", width: 100 },
                            { command: ["edit"], title: "Action", width: "100px"}]
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
                        e.container.data("kendoWindow").title('Add New Item');
                        $("a.k-grid-update")[0].innerHTML = "<span class='k-icon k-update'></span>Save";
                        isInsert = true;
                    }
                    else {
                        e.container.data("kendoWindow").title('Edit Item');
                        $('[name="ItemID"]').attr("readonly", true);
                        $('[name="ItemCode"]').attr("readonly", true);
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
                        if(name.length>0)
                        {
                         oItem[name] = $("[name=" + name + "]").val();
                        }

                    }
                    var listCheckBox = $("input:checkbox");
                    for (var i = 0; i < listCheckBox.length; i++) {
                        var name = listCheckBox[i].name;
                        if(name.length>0)
                        {
                            if ($("[name=" + name + "]").is(':checked')) {
                                oItem[name] = 'true';
                            }
                            else {
                                oItem[name] = 'false';
                            }
                        }
                    }
                    oItem.BasePrice = $("[name=BasePrice]").val();
                    oItem.CompanyCode = $("#ddlCompany").val();
                    //Update or Insert Item
                    $.ajax({
                        type: "POST",
                        url: "Item.aspx/UpdateItem",
                        data: JSON.stringify({
                            oItem: JSON.stringify(oItem),
                            isInsert: isInsert
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (isInsert) {
                        location.reload();
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
    <script type="text/x-kendo-template" id="template">  
        <div class="k-edit-label" style="display:none;">
            <label for="ItemID">
                ID</label></div>
        <div class="k-edit-field" data-container-for="ItemID"  style="display:none;">
            <input name="ItemID" class="k-input k-textbox"  type="text" data-bind="value:ItemID"></div>
        <div class="k-edit-label">
            <label for="ItemCode">
                Code</label></div>
        <div class="k-edit-field" data-container-for="ItemCode">
            <input name="ItemCode" class="k-input k-textbox" required="required" type="text"
                data-bind="value:ItemCode"></div>
        <div class="k-edit-label">
            <label for="ItemName">
                Name</label></div>
        <div class="k-edit-field" data-container-for="ItemName">
            <input name="ItemName" class="k-input k-textbox" required="required" type="text"
                data-bind="value:ItemName"></div>
        <div class="k-edit-label"  style="display:none;">
            <label for="CompanyCode">
                Company</label></div>
        <div data-container-for="CompanyCode" class="k-edit-field"  style="display:none;">
         <input id="ddlCompany" name="CompanyCode" data-bind="value:CompanyCode" validationMessage = "Company is required")>
        </div>
        <div class="k-edit-label">
            <label for="BasePrice">
                Price</label></div>
        <div class="k-edit-field" data-container-for="BasePrice">
            <input type="text" name="BasePrice" style="text-align:right;" required="required" min="0" data-type="number" data-bind="value:BasePrice" data-role="numerictextbox" role="spinbutton" class="k-input" aria-valuemin="0" aria-valuenow="234324345435" aria-disabled="false" aria-readonly="false" style="display: none;">
            </div>
        <div class="k-edit-label">
            <label for="AllowPromotion">
                Allow Promotion</label></div>
        <div class="k-edit-field" data-container-for="AllowPromotion">
            <input name="AllowPromotion" type="checkbox" data-bind="checked:AllowPromotion" data-type="boolean"></div>
        <div class="k-edit-label">
            <label for="IsActive">
                Active</label></div>
        <div class="k-edit-field" data-container-for="IsActive">
            <input name="IsActive" type="checkbox" data-bind="checked:IsActive" data-type="boolean"></div>
    </script>
    <div style="position: absolute; z-index: 0;">
        <div id="grid">
        </div>
    </div>
</asp:Content>
