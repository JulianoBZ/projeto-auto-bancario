<%-- 
    Document   : login
    Created on : 31 de mai. de 2023, 23:17:32
    Author     : Juliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Conector Conector = Conector.new();
   Conector.view_table(Conector.connectDB());
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form action="balanco.jsp" method="post">
            Usuário:<br><input type="text" name="usuario"/><br>
            Senha:<br><input type="text" name="senha"/><br>
            <input type="submit" value="Login">
            
            
        </form>
    </body>
</html>
