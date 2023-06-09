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
            int id = 0;
            if (usuario == null){
                response.sendRedirect("index.jsp");
            }else{
                id = (int) session.getAttribute("id");
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
                
                <form method='post' action='insert_balanco.jsp'>
                <label>Criar nova entrada de gasto:</label>
                <br>
                <input type='number' required name='valor' min='0' value='0.00' step='.01'>Valor: (ex: 12,34)</input>
                <br>
                <select id='insert' name='tipo'>
                <option value='Compras'>Compras</option>
                <option value='Contas'>Contas</option>
                <option value='Saude'>Saúde</option>
                <option value='Lazer'>Lazer</option>
                <option value='Educacao'>Educação</option>
                <option value='Alimentacao'>Alimentação</option>
                <option value='Transporte'>Transporte</option>
                </select>
                <br>
                    <button type='submit' name='submitButtonConta'>Novo Gasto</button>
                </form>
                
                <form method='post' action='resultado_select.jsp'>
                    <label>Selecionar período (a quantos dias) e tipo de conta (Opcional)</label>
                    <br>
                    <input type='number' name='dias' value='0'></input>
                    <br>
                    <select id='select' name='tipo'>
                        <option value='Todos'>Todos</option>
                        <option value='Compras'>Compras</option>
                        <option value='Contas'>Contas</option>
                        <option value='Saude'>Saúde</option>
                        <option value='Lazer'>Lazer</option>
                        <option value='Educacao'>Educação</option>
                        <option value='Alimentacao'>Alimentação</option>
                        <option value='Transporte'>Transporte</option>
                    </select>
                    <button type='submit' name='submitButtonRelatorio'>Ver relatório</button>
                </form>
                
                
            <%}%>
            
        <!-- Encaminhando o usuário para a página de logout -->
        <br> <a href="logout.jsp"> Logout </a>
    </body>
</html>
