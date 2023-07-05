<!--#include file="database/connect.asp"-->

<%
Dim customerName, customerEmail, customerAddress, customerNote,customerSDT
customerName = Request.Form("ten")
customerEmail = Request.Form("mail")
customerAddress = Request.Form("diachi")
customerNote = Request.Form("ghichu")
customerSDT  = Request.Form("sdt")
' Mở kết nối với cơ sở dữ liệu
connDB.Open()

' Thực hiện truy vấn INSERT để lưu thông tin người mua hàng vào bảng "khachhang" trong cơ sở dữ liệu
Dim sqlString
sqlString = "INSERT INTO Customers (Name, Email, Address, Note, SDT) VALUES ('" & customerName & "', '" & customerEmail & "', '" & customerAddress & "', '" & customerNote & "','"&customerSDT&"')"
connDB.Execute(sqlString)

' Lấy ID của khách hàng vừa được thêm vào cơ sở dữ liệu
Dim customerID
customerID = connDB.Execute("SELECT @@IDENTITY AS ID").Fields("ID").Value
Response.Write(CustomerID)
' Kiểm tra xem có thành công lấy được ID khách hàng hay không
If customerID <> "" Then
    ' Lặp qua từng sản phẩm trong giỏ hàng
    Dim carts
    Set carts = Session("mycarts")
    
    ' Duyệt qua các phần tử trong carts và hiển thị thông tin
    Dim item
    For Each item In carts
        Dim productId
        Dim quantity
        productId = item
        quantity = carts(item)
        
        ' Hiển thị thông tin sản phẩm và số lượng
        sqlString = "SELECT * FROM sanpham5 WHERE MASP = " & productId
        Set result = connDB.Execute(sqlString)

        ' Kiểm tra xem truy vấn thành công và có bản ghi tồn tại hay không
        If Not result.EOF Then
            ' Lấy các thông tin sản phẩm từ bản ghi
            Dim productName, price
            productName = result("TENSP")
            price = result("GIABANSP") * quantity

            ' Thực hiện truy vấn INSERT để lưu thông tin đơn hàng vào cơ sở dữ liệu
            sqlString = "INSERT INTO Orders1 (CustomerID, MASP, Quantity, ProductName, Price) VALUES (" & customerID & ", " & productID & ", " & quantity & ", '" & productName & "', " & price & ")"
            connDB.Execute(sqlString)
            'Thêm sản phẩm vào chi tiết hóa đơn khi save hóa đơn'
            Dim OrderID
            OrderID = connDB.Execute("SELECT @@IDENTITY AS OrderID").Fields("OrderID").Value
            Response.Write(OrderID)
            sqlString2 = "INSERT INTO ChiTietHoaDon (MaSp, MaHD, SoLuong) VALUES ( " & productID & ",'" & OrderID & "'," & quantity & ")"
            connDB.Execute(sqlString2)
        End If

        result.Close()
    Next
End If

' Đóng kết nối với cơ sở dữ liệu
connDB.Close()
Response.Redirect "dathangThanhCong.asp"
%>