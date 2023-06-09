<%-- 
    Document   : balanco
    Created on : 1 de jun. de 2023, 14:28:37
    Author     : Juliano
--%>

<%@ page import="conector.Conector" %>
<%@ page import="java.util.ArrayList" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    Conector con = new Conector();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Balanço das Contas</title>
        <style>
    table, th, td {
      border:1px solid black;
    }
    </style>
    </head>
    <body>
        
        <%          
            String usuario = (String) session.getAttribute("usuario");
            int id = (int) session.getAttribute("id");
            if (usuario == null){
                response.sendRedirect("index.jsp");
            }else{
                out.print("Bem vindo, "+usuario+" /ID: "+id+"<br>");
                
                ArrayList<String> vl_valor = con.Request_value(con.connectDB(),"vl_valor","transacao","id_usuario = "+id);
                ArrayList<String> nm_tipo = con.Request_value(con.connectDB(),"nm_tipo","transacao","id_usuario = "+id);
                ArrayList<String> dt_data = con.Request_value(con.connectDB(),"dt_data","transacao","id_usuario = "+id);
                %>
                
                <table>
                    <tr>
                    <th>Valor</th>
                    <th>Tipo</th>
                    <th>Data</th>
                    </tr>
                <%for(int i = 0; i < vl_valor.size(); i++){%>
                <tr>
                    <td><%= vl_valor.get(i)%></td>
                    <td><%= nm_tipo.get(i)%></td>
                    <td><%= dt_data.get(i)%></td>
                </tr>
                <%}%>
                </table>
            
            
             <h1></h1>
            
            
            <%}%>
        
       
        <% 
            //ArrayList<String> teste = new ArrayList<String>();
            //ArrayList<String> teste2 = new ArrayList<String>();
            //teste = con.Request_value(con.connectDB(),"*","transacao","id_usuario","= 1");
            //out.println(teste); 
        %>
            
        <!-- Encaminhando o usuário para a página de logout -->
        <br> <a href="logout.jsp"> Logout </a>
    </body>
</html>
