<%-- 
    Document   : login
    Created on : 31 de mai. de 2023, 23:17:32
    Author     : Juliano
--%>

<%@ page import="conector.Conector" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% Conector con = new Conector();
   //ArrayList<String> teste = Con.Request_value(Con.connectDB(),"id_usuario","usuario",null,null);
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- Formulário de login, redicerionando para a própria página index -->
        <h1>Login</h1>
        <form action="index.jsp" method="post">
            Usuário:<br><input type="text" name="usuario"/><br>
            Senha:<br><input type="text" name="senha"/><br>
            <input type="submit" value="Login">
            <br>            <br>            <br>
        <!-- Formulário de Registro, redicerionando para a página "registrar.jsp" -->
        <h1>Registrar novo usuário</h1>
        </form>
        <form action="registrar.jsp" method="post">
            Usuário:<br><input type="text" name="usuario"/><br>
            Senha:<br><input type="text" name="senha"/><br>
            <input type="submit" value="Login">
        </form>
         <%
            //Ao tentar login:
            //Pegando as variáveis
            String usuario = request.getParameter("usuario");
            String senha = request.getParameter("senha");
            //Fazendo variáveis alternativas para serem lidas pelo SQL
            String sql_usuario = "'"+usuario+"'";
            String sql_senha = "'"+senha+"'";
            
            //Definindo variaveis de validação que serão preenchidas com valores de uma busca SQL
            ArrayList<String> val_usuario = new ArrayList<String>();
            ArrayList<String> val_senha = new ArrayList<String>();
                    
            if (usuario != null && senha != null && !usuario.isEmpty() && !senha.isEmpty()){
            
                //Preenchendo as variaveis de validação
                val_usuario = (con.Request_value(con.connectDB(),"nm_nome","usuario","nm_nome = "+sql_usuario));
                val_senha = (con.Request_value(con.connectDB(),"nm_senha","usuario","nm_senha = "+sql_senha));
                
                if (val_usuario != null && val_senha != null){
                    //Se as variáveis de validação forem iguais às preenchidas, encaminhar o usuário para a próxima página
                    if (val_usuario.contains(usuario) && val_senha.contains(senha)){
                        session.setAttribute("usuario", usuario);
                        session.setAttribute("id",con.Request_ID(con.connectDB(),usuario));
                        response.sendRedirect("balanco.jsp");
                    }
                }
            }
         %>
    </body>
</html>
