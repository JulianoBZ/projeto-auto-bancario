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
        <title>Auto Bancario</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <style>
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: sans-serif;
            }
            
            .card-body{
                display: flex;
                
            }
            
            .coluna1{
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                width: 40%;
                height: 100vh;
                background-color: #0FECC7; 
            }
            .coluna2{
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                background-color: #fff;
                width: 60%;
            }
            
            #titulo1{
                color: #fff;
                margin-bottom: 30px;
                
            }
            
            #titulo2{
                color: #0FECC7;
                margin-bottom: 30px;
            }
            
            .botao{
                color: #fff;
                width: 200px;
                height: 40px;
                border: 2px solid #fff;
                cursor: pointer;
                border-radius: 20px;
                background-color: #0FECC7;
                font-weight: bold;
                text-decoration: none;
                font-size: 18px;
                margin-top: 16px;
            }
            
            #inputFormulario{
                margin-top: 8px;
                width: 400px;
                height: 35px;
                border-radius: 15px;
                border: none;
                background-color: #f6f6f6;
                padding-left: 8px;
                padding-right: 8px;
                outline: none;
            }
            
            .strong{
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <!-- Formulário de login, redicerionando para a própria página index -->
        <%@include file="WEB-INF/jspf/navbar.jspf"%>
        <div class="card-body">
            
            
            
                <div class="coluna1">
                <form action="index.jsp" method="post" class="m-5">
                    <h1 id="titulo1">Login</h1>

                    <label for="usuario"><strong>Usuário:</strong></label><br>
                    <input id="inputFormulario" type="text" name="usuario" placeholder="usuário"/><br><br>

                    <label for="senha"><strong>Senha:</strong></label><br>
                    <input id="inputFormulario" type="password" name="senha" placeholder="senha"/><br>

                    <button class="botao" type="submit" value="Login"><strong>Login</strong></button>
                </form>
                </div>
               
                <!-- Formulário de Registro, redicerionando para a página "registrar.jsp" -->

            
                
                <div class="coluna2">
                <form action="registrar.jsp" method="post" class="m-5">
                    <h1 id="titulo2">Cadastrar novo usuário</h1>
                    
                    <label for="usuario"><strong>Usuário:</strong></label><br>
                    <input id="inputFormulario" type="text" name="usuario" placeholder="usuário"/><br><br>

                    <label for="senha"><strong>Senha</strong></label><br>
                    <input id="inputFormulario" type="password" name="senha" placeholder="senha"/><br>

                    <button class="botao" type="submit" value="Login" ><strong>Cadastrar</strong></button>
                </form>
                </div>
            
            
        </div>
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
