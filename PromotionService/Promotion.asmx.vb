﻿Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.ComponentModel

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<System.Web.Services.WebService(Namespace:="http://tempuri.org/")> _
<System.Web.Services.WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ToolboxItem(False)> _
Public Class Promotion
    Inherits System.Web.Services.WebService
#Region "Update"
    <WebMethod()> _
    Public Function UpdateJsonCompany(ByVal userId As String, ByVal passWord As String, _
                                       ByVal companyCode As String, ByVal companyName As String, ByVal isActive As Boolean, ByVal address As String, _
                                        ByVal contactPerson As String, ByVal contactPhone As String, _
                                       ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim promotion As New clsPromotion
        Return promotion.UpdateJsonCompany(userId, passWord, companyCode, companyName, isActive, address, contactPerson, contactPhone, databaseName, isInsert)

    End Function
    <WebMethod()> _
    Public Function UpdateJsonUser(ByVal userId As String, ByVal passWord As String, _
                                     ByVal oUserID As String, ByVal userName As String, ByVal CompanyCode As String, ByVal UserPassword As String, _
                                     ByVal IsAdmin As Boolean, ByVal IsActive As Boolean, ByVal IsTrial As Boolean, ByVal Email As String, ByVal Phone As String, _
                                     ByVal databaseName As String, ByVal isInsert As Boolean) As String

        Dim promotion As New clsPromotion
        Return promotion.UpdateJsonUser(userId, passWord, oUserID, userName, CompanyCode, UserPassword, IsAdmin, IsActive, IsTrial, Email, Phone, databaseName, isInsert)

    End Function
    <WebMethod()> _
    Public Function UpdateCompany(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim promotion As New clsPromotion
        Return promotion.UpdateCompany(userId, passWord, data, databaseName, isInsert)
    End Function
    <WebMethod()> _
    Public Function UpdateUser(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim promotion As New clsPromotion
        Return promotion.UpdateUser(userId, passWord, data, databaseName, isInsert)
    End Function
    <WebMethod()> _
    Public Function UpdateCustomer(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim promotion As New clsPromotion
        Return promotion.UpdateCustomer(userId, passWord, data, databaseName, isInsert)
    End Function
    <WebMethod()> _
    Public Function UpdateItem(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim promotion As New clsPromotion
        Return promotion.UpdateItem(userId, passWord, data, databaseName, isInsert)
    End Function
#End Region
#Region "Query"
    <WebMethod()> _
    Public Function GetAllCompany(ByVal dataBaseName As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetAllCompany(dataBaseName)
    End Function
    <WebMethod()> _
    Public Function GetCompanyByCode(ByVal dataBaseName As String, ByVal companyCode As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetCompanyByCode(dataBaseName, companyCode)
    End Function
    <WebMethod()> _
    Public Function GetAllUser(ByVal dataBaseName As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetAllUser(dataBaseName)
    End Function
    <WebMethod()> _
    Public Function GetUserByUserName(ByVal dataBaseName As String, ByVal userName As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetUserByUserName(dataBaseName, userName)
    End Function
    <WebMethod()> _
    Public Function GetAllCustomer(ByVal dataBaseName As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetAllCustomer(dataBaseName)
    End Function
    <WebMethod()> _
    Public Function GetCustomerByCode(ByVal dataBaseName As String, ByVal customerCode As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetCustomerByCode(dataBaseName, customerCode)
    End Function
    <WebMethod()> _
    Public Function GetAllItem(ByVal dataBaseName As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetAllItem(dataBaseName)
    End Function
    <WebMethod()> _
    Public Function GetItemByCode(ByVal dataBaseName As String, ByVal itemCode As String) As DataSet
        Dim promotion As New clsPromotion
        Return promotion.GetItemByCode(dataBaseName, itemCode)
    End Function
#End Region

End Class