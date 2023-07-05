<!-- #include file="./database/connect.asp" -->
<%
'lay ve danh sach product theo id trong my cart
Dim idList, mycarts, totalProduct, subtotal, rs
If (NOT IsEmpty(Session("mycarts"))) Then

' true
	Set mycarts = Session("mycarts")
	idList = ""
	totalProduct=mycarts.Count    
	For Each List In mycarts.Keys
		If (idList="") Then
' true
			idList = List
		Else
			idList = idList & "," & List
		End if                               
	Next
	Dim sqlString
	sqlString = "Select * from sanpham5 where MASP IN (" & idList &")"
	connDB.Open()
	set rs = connDB.execute(sqlString)
	calSubtotal(rs)

  Else
   
    totalProduct=0
  End If
  Sub calSubtotal(rs)
' Do Something...
		subtotal = 0
		do while not rs.EOF
			subtotal = subtotal + Clng(mycarts.Item(CStr(rs("id")))) * CDbl(CStr(rs("Price")))
			rs.MoveNext
		loop
		rs.MoveFirst
	End Sub
  Sub defineItems(v)
    If (v>1) Then
      Response.Write(" Items")
    Else
      Response.Write(" Item")
    End If
  End Sub
%>
<!-- #include file="inc/header.asp" -->
<div class="container">
    <h1>Mua hàng thành công</h1>
    <div class="success-message">
        <p>Cảm ơn bạn đã đặt hàng!</p>
        <p>Đơn hàng của bạn đã được xử lý thành công.</p>
    </div>
    <h2>Thông tin đơn hàng</h2>
    <table class="order-details">
        <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá</th>
            </tr>
        </thead>
        <tbody>
            <!-- Thêm các hàng dữ liệu về sản phẩm từ CSDL ở đây -->
              <%
            If (totalProduct<>0) Then
            do while not rs.EOF
            %>
                    <tr class="cart-item">
                        <td class="product-name"><%=rs("TenSp")%></td>
                        
                        <td><strong class="product-quantity"> <%
                                Dim ik
                                ik  = CStr(rs("id"))
                                Response.Write(mycarts.Item(ik))  %></strong></td>
                        <td class="product-total"><%=(CDbl(rs("Price"))*mycarts.Item(ik))%></td>
                    </tr>
            <%
            rs.MoveNext
            loop
            'phuc vu cho viec update subtotal
            rs.MoveFirst
            End If
            %> 
            <!-- Kết thúc các hàng dữ liệu -->
        </tbody>
        <tfoot>
            <tr>
                <th colspan="2">Tổng đơn hàng:</th>
                <th><%=subtotal%>đ</th>
            </tr>
        </tfoot>
    </table>
    <a href="shopping.asp">Trở lại</a>
</div>
  <!-- #include file="inc/footer.asp" -->