<%-- 
    Document   : logout
    Created on : 1 de jun. de 2023, 14:52:48
    Author     : Juliano
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //Matando a sessão e retornando para a tela inicial
    session.invalidate();
    response.sendRedirect("index.jsp");
%>
