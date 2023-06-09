<%-- 
    Document   : resultado_select
    Created on : 6 de jun. de 2023, 19:03:34
    Author     : Mary
--%>

<%@ page import="conector.Conector" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    Conector con = new Conector();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resultado Select</title>
            <style>
            table, th, td {
              border:1px solid black;
            }
            </style>
    
    </head>
    <body>
        <h3>Resultado da Pesquisa</h3>
        
        <%
            //Variáveis POST e de sessão
            String tipo = request.getParameter("tipo");
            int dias = Integer.parseInt(request.getParameter("dias"));
            int id = (int) session.getAttribute("id");
            
            //Inicializando variáveis
            ArrayList<Float> vl_valor = new ArrayList<Float>();
            ArrayList<String> nm_tipo = new ArrayList<String>();
            ArrayList<String> dt_data = new ArrayList<String>();
            
            //Se o tipo selecionado não for "Todos", ele irá selecional dependendo do tipo de transação
            if(!tipo.equals("Todos")){
                   vl_valor = con.Request_vl_valor(con.connectDB(),"vl_valor","transacao","id_usuario = "+id+" and nm_tipo = '"+tipo+"' and dt_data BETWEEN DATE('now','-"+dias+" day') and DATE('now')");
                   nm_tipo = con.Request_value(con.connectDB(),"nm_tipo","transacao","id_usuario = "+id+" and nm_tipo = '"+tipo+"' and dt_data BETWEEN DATE('now','-"+dias+" day') and DATE('now')");
                   dt_data = con.Request_value(con.connectDB(),"dt_data","transacao","id_usuario = "+id+" and nm_tipo = '"+tipo+"' and dt_data BETWEEN DATE('now','-"+dias+" day') and DATE('now')");
            }else{
                vl_valor = con.Request_vl_valor(con.connectDB(),"vl_valor","transacao","id_usuario = "+id);
                nm_tipo = con.Request_value(con.connectDB(),"nm_tipo","transacao","id_usuario = "+id);
                dt_data = con.Request_value(con.connectDB(),"dt_data","transacao","id_usuario = "+id);
            }
        %>
        
        
        <table style="width:100%">
        <tr>
        <th>Valor</th>
        <th>Tipo</th>
        <th>Data</th>
        </tr>
        
        <%
           //Criando variáveis para o gráfico
           float total = 0;
           float tot_conta = 0;
           float tot_compras = 0;
           float tot_saude = 0;
           float tot_lazer = 0;
           float tot_educacao = 0;
           float tot_alimentacao = 0;
           float tot_transporte = 0;
           
           
           //Para cada valor, dependendo do tamanho de um dos ArrayList, exibir o valor na posição 'j'
           if(vl_valor.size()>0){
                for(int j = 0; j < vl_valor.size(); j++){
                %><tr>
                    <td><%= vl_valor.get(j)%></td>
                    <td><%= nm_tipo.get(j)%></td>
                    <td><%= dt_data.get(j)%></td>
                </tr><%
                    switch(nm_tipo.get(j)){
                        case "Contas":
                            tot_conta += vl_valor.get(j);
                            break;
                        case "Compras":
                            tot_compras += vl_valor.get(j);
                            break;
                        case "Saude":
                            tot_saude += vl_valor.get(j);
                            break;
                        case "Lazer":
                            tot_lazer += vl_valor.get(j);
                            break;
                        case "Educacao":
                            tot_educacao += vl_valor.get(j);
                            break;
                        case "Alimentacao":
                            tot_alimentacao += vl_valor.get(j);
                            break;
                        case "Transporte":
                            tot_transporte += vl_valor.get(j);
                            break;
                    }
                    total += vl_valor.get(j);
                }
                tot_conta = (tot_conta/total) * 100;
                tot_compras = (tot_compras/total) * 100;
                tot_saude = (tot_saude/total) * 100;
                tot_lazer = (tot_lazer/total) * 100;
                tot_educacao = (tot_educacao/total) * 100;
                tot_alimentacao = (tot_alimentacao/total) * 100;
                tot_transporte = (tot_transporte/total) * 100;
            }
        %>
        
        <%
            Gson gsonObj = new Gson();
            Map<Object,Object> map = null;
            List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();

            map = new HashMap<Object,Object>(); map.put("label", "Contas"); map.put("y", tot_conta); list.add(map);
            map = new HashMap<Object,Object>(); map.put("label", "Compras"); map.put("y", tot_compras); list.add(map);
            map = new HashMap<Object,Object>(); map.put("label", "Saúde"); map.put("y", tot_saude); list.add(map);
            map = new HashMap<Object,Object>(); map.put("label", "Lazer"); map.put("y", tot_lazer); list.add(map);
            map = new HashMap<Object,Object>(); map.put("label", "Educação"); map.put("y", tot_educacao); list.add(map);
            map = new HashMap<Object,Object>(); map.put("label", "Alimentação"); map.put("y", tot_alimentacao); list.add(map);
            map = new HashMap<Object,Object>(); map.put("label", "Transporte"); map.put("y", tot_transporte); list.add(map);

            String dataPoints = gsonObj.toJson(list);
        %>
        
        
        
        </table>
    <div id="chartContainer" style="height: 370px; width: 100%;"></div>
    <script>
        window.onload = function() {

        <% if(tipo != null){ %>
        var chart = new CanvasJS.Chart("chartContainer", {
                animationEnabled: true,
                title: {
                        text: "Gráfico de % dos gastos Selecionados"
                },
                data: [{
                        type: "pie",
                        yValueFormatString: "#,##0.00\"%\"",
                        indexLabel: "{label} ({y})",
                        dataPoints: <% out.print(dataPoints); %>
                }]
        });
        chart.render();
        <% } %>
        }
    </script>
    <!-- Script para inserção de gráfico -->
    <script src="https://cdn.canvasjs.com/canvasjs.min.js"></script>
    </body>
</html>
