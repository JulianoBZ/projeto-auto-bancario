<%-- 
    Document   : registrar
    Created on : 9 de jun. de 2023, 20:31:50
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
        <title>JSP Page</title>
    </head>
    <body>
        <%
           //Ao registrar novo usuário:
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
                    //Se as variáveis de validação não existirem, criar usuário e enviar para a página de balanço
                    if (!val_usuario.contains(usuario) && !val_senha.contains(senha)){
                        //criando usuário
                        con.create_user(con.connectDB(),usuario,senha);
                        session.setAttribute("usuario", usuario);
                        session.setAttribute("id",con.Request_ID(con.connectDB(),usuario));
                        response.sendRedirect("balanco.jsp");
                    }
                }
                else{
                response.sendRedirect("index.jsp");
            }
            }  
        %>
    </body>
</html>
