<%-- 
    Document   : insert_balanco
    Created on : 6 de jun. de 2023, 13:23:09
    Author     : Mary
--%>

<%@ page import="conector.Conector" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    Conector con = new Conector();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
        float valor =  Float.parseFloat(request.getParameter("valor"));
        String tipo = request.getParameter("tipo");
        int id = (int) session.getAttribute("id");
        out.println(valor);
        try{
            con.insert_transaction(con.connectDB(),valor,tipo,id);
        }catch(Exception e){
            System.out.println(e);
        }finally{
        response.sendRedirect("balanco.jsp");
        }

        %>
        <h1>Hello World!</h1>
    </body>
</html>
