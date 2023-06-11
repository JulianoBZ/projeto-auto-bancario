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
    
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: sans-serif;
    }
    
    .geral{
        display: flex;
    }
    
    .container1{
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 40%;
        height: 100vh;
        background-color: #0FECC7; 
    }
    
    .container2{
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        background-color: #fff;
        width: 60%;
    }
    
    .botao-despesas{
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
    
    .despesas{
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
    
    .selecionar{
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
    
    .logout{
        background-color: #0FECC7; 
        border-radius: 15px;
        color: darkred;
        padding: 10px;
        margin-top: 12px;
        width: 75px;
        height: 35px;
        border: none;
    }
    
    .containerled {
        display: flex;
        flex-direction: column;
    }
    </style>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navbar.jspf"%>
        
    <div class="geral">
        
        <div class="container1">
            <p> <h2><strong>Cliente</strong></h2></p>
        
            <p><strong>
                <%  
                //Pegando variáveis de sessão
                String usuario = (String) session.getAttribute("usuario");
                int id = 0;
                if (usuario == null){
                    response.sendRedirect("index.jsp");
                }else{
                    id = (int) session.getAttribute("id");
                    out.print("Seja bem vindo, "+usuario+" /ID: "+id+"<br>");

                    //Preenchendo ArrayLists com valores a serem exibidos
                    ArrayList<String> vl_valor = con.Request_value(con.connectDB(),"vl_valor","transacao","id_usuario = "+id);
                    ArrayList<String> nm_tipo = con.Request_value(con.connectDB(),"nm_tipo","transacao","id_usuario = "+id);
                    ArrayList<String> dt_data = con.Request_value(con.connectDB(),"dt_data","transacao","id_usuario = "+id);
                    %>
            </strong></p>
                <!-- Tabela que exibirá os dados -->
            <table>
                <tr>
                    <th>Valor</th><br>
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
                
            <!-- Formulário para inserir nova transação no balanço de contas -->
                
            <form method='post' action='insert_balanco.jsp'>

                <br><label for="valor"><strong>Valor da despesa:</strong></label><br>
                <input class="despesas"type='number' required name='valor' min='0' placeholder="digite o valor"></input>
                <br><br>
            <label for="tipo"><strong>Despesa com:</strong></label><br>
                <select class="selecionar"id='insert' name='tipo'>
                    <option value='Compras'>Compras</option>
                    <option value='Contas'>Contas</option>
                    <option value='Saude'>Saúde</option>
                    <option value='Lazer'>Lazer</option>
                    <option value='Educacao'>Educação</option>
                    <option value='Alimentacao'>Alimentação</option>
                    <option value='Transporte'>Transporte</option>
                </select>
            <br>
                <button class="botao-despesas"type='submit' name='submitButtonConta'>Nova despesa</button>
            </form>
        </div>
                <!-- Formulário para ver o balanço das contas de acordo com categoria (ou não) e fornecendo um gráfico, se não for escolhida uma categoria, das porcentagens de cada tipo de gasto -->
                
        <div class="container2">
            
        <p> 
        <h2><strong>Relatório</strong></h2><br>
        </p>
                <form class="containerled" method='post' action='resultado_select.jsp'>
                    <label for="dias"><strong>Período desejado:</strong></label>
                    <input class="despesas" type='number' name='dias' placeholder="número de dias"></input><br>
                    <label for="tipo"><strong>Selecionar tipo de despesa desejada:</strong></label>
                    <select class="selecionar"id='select' name='tipo'>
                        <option value='Todos'>Todos</option>
                        <option value='Compras'>Compras</option>
                        <option value='Contas'>Contas</option>
                        <option value='Saude'>Saúde</option>
                        <option value='Lazer'>Lazer</option>
                        <option value='Educacao'>Educação</option>
                        <option value='Alimentacao'>Alimentação</option>
                        <option value='Transporte'>Transporte</option>
                    </select>
                    <button class="botao-despesas"type='submit' name='submitButtonRelatorio'>Ver relatório</button>
                    <a class="logout" href="logout.jsp"> Logout </a>
                </form>
            
        </div>
              
            <%}%>
    
        <!-- Encaminhando o usuário para a página de logout -->
        
    
    </div>    
    </body>
</html>
