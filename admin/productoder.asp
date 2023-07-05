<!--#include file="./connect.asp"-->
<%

' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
' trang hien tai
    page = Request.QueryString("page")
    limit = 5

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(OrderID) AS count FROM Orders1"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
%>



<!--#include file="./header.asp"-->
<!--#include file="./slider.asp"-->

    <div class="content">
        <div class="alert alert-success" role="alert">
            <%
                  if(Session("Success")<>"") then
                     Response.write(Session("Success"))
                  end if
              %>
          </div>
    
         <table class="table table-striped">
            <thead>
              <tr>
                <th scope="col">MÃ ĐƠN HÀNG </th>
                <th scope="col">MÃ ĐẶT HÀNG</th>
                <th scope="col">MÃ SẢN PHẨM</th>
                <th scope="col">SỐ LƯỢNG</th>
                <th scope="col">TÊN SẢN PHẨM</th>
                <th scope="col">GIÁ</th>
                              
              </tr>
            </thead>
            <tbody>
            <%
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType = 1
                    cmdPrep.Prepared = True
                    cmdPrep.CommandText = "SELECT * FROM Orders1 ORDER BY OrderID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                    cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)
                    Set Result = cmdPrep.execute
                    do while not Result.EOF
             %>     

            <tr>
                <td><%=Result("OrderID")%></td>
                <td><%=Result("CustomerID")%></td>
                <td><%=Result("MASP")%></td>
                <td><%=Result("Quantity")%></td>
                <td><%=Result("ProductName")%></td>     
                <td><%=Result("Price")%></td>     

                
            </tr>

                <%
                         Result.MoveNext
                     loop
                %>
            </tbody>
        </table>  
         
          <div>
            <nav aria-label="Page Navigation">
                <ul class="pagination pagination-sm">
                    <% if (pages>1) then 
                        for i= 1 to pages
                    %>
                            <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="dathang.asp?page=<%=i%>"><%=i%></a></li>
                    <%
                        next
                        end if
                    %>
                </ul>
            </nav>
        </div>  
    </div>
        
        <!--#include file="./footer.asp"-->
                       


   
  

