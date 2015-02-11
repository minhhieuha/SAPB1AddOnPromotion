Public Class clsPromotion
#Region "Update"
    Public Function UpdateJsonCompany(ByVal userId As String, ByVal passWord As String, _
                                        ByVal companyCode As String, ByVal companyName As String, ByVal isActive As Boolean, ByVal address As String, _
                                         ByVal contactPerson As String, ByVal contactPhone As String, _
                                        ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim connect As New Connection()
        Try
                Dim errMsg As String = connect.setSQLDB(databaseName)
                If errMsg.Length = 0 Then
                Dim params = New Object() {companyCode, companyName, isActive, address, contactPerson, contactPhone}
                    Dim query As String = String.Empty
                    If isInsert = True Then
                        query += "INSERT INTO [oCompany] "
                        query += " ([CompanyCode] "
                        query += ",[CompanyName] "
                        query += ",[IsActive] "
                        query += ",[Address] "
                        query += ",[ContactPerson] "
                        query += ",[ContactPhone]) "
                        query += "VALUES (@Param1,@Param2,@Param3,@Param4,@Param5,@Param6)"
                        Dim count As Integer = connect.Object_Execute_SAP(query, params)
                    Else
                        query = "UPDATE  [oCompany] SET "
                        query += ",[CompanyName] = @Param1"
                        query += ",[IsActive] = @Param2"
                        query += ",[Address] = @Param3"
                        query += ",[ContactPerson] = @Param4"
                        query += ",[ContactPhone] = @Param5"
                        query += " WHERE [CompanyCode] = @Param6"
                    connect.Object_Execute_SAP(query, New Object() {companyName, isActive, address, contactPerson, contactPhone, companyCode})
                    End If
                Else
                    Return errMsg
                End If
        Catch ex As Exception
            'WriteLog(ex.StackTrace & " " & ex.Message)
            Return ex.Message
        End Try
        Return String.Empty
    End Function
    Public Function UpdateCompany(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim connect As New Connection()
        Try
            For Each row As DataRow In data.Tables("oCompany").Rows
                Dim errMsg As String = connect.setSQLDB(databaseName)
                If errMsg.Length = 0 Then
                    Dim params = New Object() {row("CompanyCode"), row("CompanyName"), row("IsActive"), row("Address"), row("ContactPerson"), row("ContactPhone")}
                    Dim query As String = String.Empty
                    If isInsert = True Then
                        query += "INSERT INTO [oCompany] "
                        query += " ([CompanyCode] "
                        query += ",[CompanyName] "
                        query += ",[IsActive] "
                        query += ",[Address] "
                        query += ",[ContactPerson] "
                        query += ",[ContactPhone]) "
                        query += "VALUES (@Param1,@Param2,@Param3,@Param4,@Param5,@Param6)"
                        Dim count As Integer = connect.Object_Execute_SAP(query, params)
                    Else
                        query = "UPDATE  [oCompany] SET "
                        query += ",[CompanyName] = @Param1"
                        query += ",[IsActive] = @Param2"
                        query += ",[Address] = @Param3"
                        query += ",[ContactPerson] = @Param4"
                        query += ",[ContactPhone] = @Param5"
                        query += " WHERE [CompanyCode] = @Param6"
                        connect.Object_Execute_SAP(query, New Object() {row("CompanyName"), row("IsActive"), row("Address"), row("ContactPerson"), row("ContactPhone"), row("CompanyCode")})
                    End If
                Else
                    Return errMsg
                End If
            Next
        Catch ex As Exception
            'WriteLog(ex.StackTrace & " " & ex.Message)
            Return ex.Message
        End Try
        Return String.Empty
    End Function
    Public Function UpdateJsonUser(ByVal userId As String, ByVal passWord As String, _
                                       ByVal oUserID As String, ByVal userName As String, ByVal CompanyCode As String, ByVal UserPassword As String, _
                                       ByVal IsAdmin As Boolean, ByVal IsActive As Boolean, ByVal IsTrial As Boolean, ByVal Email As String, ByVal Phone As String, _
                                       ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim connect As New Connection()
        Try
            Dim errMsg As String = connect.setSQLDB(databaseName)
            If errMsg.Length = 0 Then
                Dim params = New Object() {userName, CompanyCode, UserPassword, IsAdmin, IsActive, IsTrial, Email, Phone}
                Dim query As String = String.Empty
                If isInsert = True Then
                    query = " INSERT INTO [oUser]"
                    query += " ([UserName] "
                    query += " ,[CompanyCode] "
                    query += " ,[Password] "
                    query += " ,[IsAdmin] "
                    query += " ,[IsActive] "
                    query += " ,[IsTrial] "
                    query += " ,[Email] "
                    query += " ,[Phone]) "
                    query += "VALUES (@Param1,@Param2,@Param3,@Param4,@Param5,@Param6,@Param7,@Param8)"
                    Dim count As Integer = connect.Object_Execute_SAP(query, params)
                Else
                    query = "UPDATE  [oUser] SET "
                    query += "  ,[CompanyCode] = @Param1"
                    query += "  ,[Password] = @Param2"
                    query += "  ,[IsAdmin] = @Param3"
                    query += "  ,[IsActive] = @Param4"
                    query += "  ,[IsTrial] = @Param5"
                    query += "  ,[Email] = @Param6"
                    query += "  ,[Phone] = @Param7"
                    query += "  ,[UserName] = @Param8"
                    query += " WHERE [UserID] = @Param9"
                    connect.Object_Execute_SAP(query, New Object() {CompanyCode, UserPassword, IsAdmin, IsActive, IsTrial, Email, Phone, userName, userId})
                End If
            Else
                Return errMsg
            End If
        Catch ex As Exception
            'WriteLog(ex.StackTrace & " " & ex.Message)
            Return ex.Message
        End Try
        Return String.Empty
    End Function
    Public Function UpdateUser(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim connect As New Connection()
        Try
            For Each row As DataRow In data.Tables("oUser").Rows
                Dim errMsg As String = connect.setSQLDB(databaseName)
                If errMsg.Length = 0 Then
                    Dim params = New Object() {row("UserName"), row("CompanyCode"), row("Password"), row("IsAdmin"), row("IsActive"), row("IsTrial"), row("Email"), row("Phone")}
                    Dim query As String = String.Empty
                    If isInsert = True Then
                        query = " INSERT INTO [oUser]"
                        query += " ([UserName] "
                        query += " ,[CompanyCode] "
                        query += " ,[Password] "
                        query += " ,[IsAdmin] "
                        query += " ,[IsActive] "
                        query += " ,[IsTrial] "
                        query += " ,[Email] "
                        query += " ,[Phone]) "
                        query += "VALUES (@Param1,@Param2,@Param3,@Param4,@Param5,@Param6,@Param7,@Param8)"
                        Dim count As Integer = connect.Object_Execute_SAP(query, params)
                    Else
                        query = "UPDATE  [oUser] SET "
                        query += "  ,[CompanyCode] = @Param1"
                        query += "  ,[Password] = @Param2"
                        query += "  ,[IsAdmin] = @Param3"
                        query += "  ,[IsActive] = @Param4"
                        query += "  ,[IsTrial] = @Param5"
                        query += "  ,[Email] = @Param6"
                        query += "  ,[Phone] = @Param7"
                        query += "  ,[UserName] = @Param8"
                        query += " WHERE [UserID] = @Param9"
                        connect.Object_Execute_SAP(query, New Object() {row("CompanyCode"), row("Password"), row("IsAdmin"), row("IsActive"), row("IsTrial"), row("Email"), _
                                                                        row("Phone"), row("UserName"), row("UserID")})
                    End If
                Else
                    Return errMsg
                End If
            Next
        Catch ex As Exception
            'WriteLog(ex.StackTrace & " " & ex.Message)
            Return ex.Message
        End Try
        Return String.Empty
    End Function
    Public Function UpdateCustomer(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim connect As New Connection()
        Try
            For Each row As DataRow In data.Tables("oCustomer").Rows
                Dim errMsg As String = connect.setSQLDB(databaseName)
                If errMsg.Length = 0 Then
                    Dim params = New Object() {row("CustomerCode"), row("CustomerName"), row("CreatedUserID"), row("IsActive"), row("BillingAddress"), _
                                              row("ShippingAddress"), row("ContactPerson"), row("PhoneNumber"), row("Email")}
                    Dim query As String = String.Empty
                    If isInsert = True Then
                        query = " INSERT INTO [oCustomer]"
                        query += "  ([CustomerCode]"
                        query += " ,[CustomerName]"
                        query += " ,[CompanyCode]"
                        query += " ,[CreatedUserID]"
                        query += " ,[IsActive]"
                        query += " ,[BillingAddress]"
                        query += " ,[ShippingAddress]"
                        query += " ,[ContactPerson]"
                        query += " ,[PhoneNumber]"
                        query += " ,[Email]) "
                        query += "VALUES (@Param1,@Param2,@Param3,@Param4,@Param5,@Param6,@Param7,@Param8,@Param9,@Param10)"
                        Dim count As Integer = connect.Object_Execute_SAP(query, params)
                    Else
                        query = "UPDATE  [oCustomer] SET "
                        query += "  ,[CustomerName] = @Param1"
                        query += "  ,[CompanyCode] = @Param2"
                        query += "  ,[CreatedUserID] = @Param3"
                        query += "  ,[IsActive] = @Param4"
                        query += "  ,[BillingAddress] = @Param5"
                        query += "  ,[ShippingAddress] = @Param6"
                        query += "  ,[ContactPerson] = @Param7"
                        query += "  ,[PhoneNumber] = @Param8"
                        query += "  ,[Email] = @Param9"
                        query += "  ,[CustomerCode] = @Param10"
                        query += " WHERE [CustomerID] = @Param11"
                        connect.Object_Execute_SAP(query, New Object() {row("CustomerName"), row("CreatedUserID"), row("IsActive"), row("BillingAddress"), _
                                              row("ShippingAddress"), row("ContactPerson"), row("PhoneNumber"), row("Email"), row("CustomerCode"), row("CustomerID")})
                    End If
                Else
                    Return errMsg
                End If
            Next
        Catch ex As Exception
            'WriteLog(ex.StackTrace & " " & ex.Message)
            Return ex.Message
        End Try
        Return String.Empty
    End Function
    Public Function UpdateItem(ByVal userId As String, ByVal passWord As String, _
                                         ByVal data As DataSet, ByVal databaseName As String, ByVal isInsert As Boolean) As String
        Dim connect As New Connection()
        Try
            For Each row As DataRow In data.Tables("oItem").Rows
                Dim errMsg As String = connect.setSQLDB(databaseName)
                If errMsg.Length = 0 Then
                    Dim params = New Object() {row("ItemCode"), row("ItemName"), row("CompanyCode"), row("BasePrice"), row("CreatedUserID"), _
                                              row("IsActive"), row("AllowPromotion")}
                    Dim query As String = String.Empty
                    If isInsert = True Then
                        query = " INSERT INTO [oItem]"
                        query += "  ([ItemCode]"
                        query += "  ,[ItemName]"
                        query += "  ,[CompanyCode]"
                        query += "  ,[BasePrice]"
                        query += "  ,[CreatedUserID]"
                        query += "  ,[IsActive]"
                        query += "  ,[AllowPromotion])"
                        query += "VALUES (@Param1,@Param2,@Param3,@Param4,@Param5,@Param6,@Param7)"
                        Dim count As Integer = connect.Object_Execute_SAP(query, params)
                    Else
                        query = "UPDATE  [oItem] SET "
                        query += "  ,[ItemName] = @Param1"
                        query += "  ,[CompanyCode] = @Param2"
                        query += "  ,[BasePrice] = @Param3"
                        query += "  ,[CreatedUserID] = @Param4"
                        query += "  ,[IsActive] = @Param5"
                        query += "  ,[AllowPromotion] = @Param6"
                        query += "  ,[ItemCode] = @Param7"
                        query += " WHERE [ItemID] = @Param8"
                        connect.Object_Execute_SAP(query, New Object() {row("ItemName"), row("CompanyCode"), row("BasePrice"), row("CreatedUserID"), _
                                              row("IsActive"), row("AllowPromotion"), row("ItemCode"), row("ItemID")})
                    End If
                Else
                    Return errMsg
                End If
            Next
        Catch ex As Exception
            'WriteLog(ex.StackTrace & " " & ex.Message)
            Return ex.Message
        End Try
        Return String.Empty
    End Function
#End Region

#Region "Query"
    Public Function GetAllCompany(ByVal dataBaseName As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oCompany")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oCompany")
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetCompanyByCode(ByVal dataBaseName As String, ByVal companyCode As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oCompany")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oCompany WHERE CompanyCode = @Param1", New Object() {companyCode})
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetAllUser(ByVal dataBaseName As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oUser")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oUser")
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetUserByUserName(ByVal dataBaseName As String, ByVal userName As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oUser")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oUser WHERE UserName = @Param1", New Object() {userName})
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetAllCustomer(ByVal dataBaseName As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oCustomer")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oCustomer")
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetCustomerByCode(ByVal dataBaseName As String, ByVal customerCode As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oCustomer")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oCustomer WHERE CustomerCode = @Param1", New Object() {customerCode})
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetAllItem(ByVal dataBaseName As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oItem")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oItem")
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function GetItemByCode(ByVal dataBaseName As String, ByVal itemCode As String) As DataSet
        Dim connect As New Connection()
        Try
            Dim ds As New DataSet("oItem")
            Dim errMsg As String = connect.setSQLDB(dataBaseName)
            If errMsg.Length = 0 Then
                ds = connect.ObjectGetAll_Query_SAP("SELECT * FROM oItem WHERE ItemCode = @Param1", New Object() {itemCode})
            End If
            Return ds
        Catch ex As Exception
            Throw ex
        End Try
    End Function
#End Region
End Class
