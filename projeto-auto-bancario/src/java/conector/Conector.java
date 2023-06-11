//definindo nome do pacote
package conector;

//importando classes a serem utilizadas
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;

public class Conector {
    
    //conexão a ser usada, foi usada para testes
    Connection con = null;

    //construtor
    public Conector(){
    }
    
    //Função que cria uma conexão com o banco usando o JDBC para SQLite
    public static Connection connectDB(){
        try{
            //cria uma conexão com o arquivo apontado
            Class.forName("org.sqlite.JDBC");
            Connection con = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\Juliano\\Documents\\NetBeansProjects\\finac\\finac.db");
            System.out.println("Conexao bem sucedida");

            return con;
        }catch(Exception e){
            System.out.println("Conexao falhou: "+e);
            return null;
        }
    }
    
    //Cria um usuário, o statement é executado e não é retornado valor
    public static void create_user(Connection con, String user, String pass){
        String query = "insert into usuario (nm_nome, nm_senha) values ('"+user+"','"+pass+"')";
        try(Statement stmt = con.createStatement()){
            stmt.executeQuery(query);
        }catch(Exception e){
            System.out.println(e);
        }
    }
    
    //Inserir uma transação, similar à função anterior
    public static void insert_transaction(Connection con, float valor, String tipo, int id){
        String query = "insert into transacao (vl_valor,nm_tipo,dt_data,id_usuario) values ("+valor+",'"+tipo+"',DATE(),"+id+")";
        try(Statement stmt = con.createStatement()){
            stmt.executeQuery(query);
        }catch(Exception e){
            System.out.println(e);
        }
    }
    
    //Requisitar valor(qualquer), dá um select no banco de acordo com os parâmetros fornecidos
    public static ArrayList<String> Request_value(Connection con, String what, String table, String condition){
        ArrayList<String> value = new ArrayList<String>();
        String query = "";
        if (condition != null){
            query = "Select "+what+" from "+table+" where "+condition;
        }else{
            query = "Select "+what+" from "+table;
        }
        
        //Cada linha do ResultSet o código pega a próxima string, se ouver, e adiciona no ArrayList a ser retornado
        try(Statement stmt = con.createStatement()){
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()){
                value.add(rs.getString(what));
            }
        }catch(Exception e){
            System.out.println(e);
        }
        System.out.println(value);
        return value;
        
    }
    
    //Requisitar a coluna vl_valor do banco, ArrayList em Float para cálculo
    public static ArrayList<Float> Request_vl_valor(Connection con, String what, String table, String condition){
        ArrayList<Float> value = new ArrayList<Float>();
        String query = "";
        if (condition != null){
            query = "Select "+what+" from "+table+" where "+condition;
        }else{
            query = "Select "+what+" from "+table;
        }
        //Cada linha do ResultSet o código pega o próximo float, se ouver, e adiciona no ArrayList a ser retornado
        try(Statement stmt = con.createStatement()){
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()){
                value.add(rs.getFloat(what));
            }
        }catch(Exception e){
            System.out.println(e);
        }
        System.out.println(value);
        return value;
        
    }
    
    //Requisitar ID, retorna somente a primeira linha do ResultSet, que será o ID de acordo com o nome de usuário fornecido
    public static int Request_ID(Connection con, String user){
        String get_id = "";
        int id = 0;
        ArrayList<String> value = new ArrayList<String>();
        String query = "";
        query = "Select id_usuario from usuario where nm_nome = '"+user+"'";
        
        try(Statement stmt = con.createStatement()){
            ResultSet rs = stmt.executeQuery(query);
            rs.next();
            id = rs.getInt(1);
        }catch(Exception e){
            System.out.println(e);
        }
        
        //get_id = value.get(0);
        //id = Integer.parseInt(get_id);
        return id;
    }
    
    //Ver tabela, usado para testes.
    public static void view_table(Connection con){
        
        String query = "Select * from usuario";
        try(Statement stmt = con.createStatement()){
            ResultSet rs = stmt.executeQuery(query);
            while ( rs.next() ) {
                String id = rs.getString("id_usuario");
                String nome = rs.getString("nm_nome");
                String senha = rs.getString("nm_senha");
                //System.out.println(id);
                //System.out.println(nome);
                //System.out.println(senha);
            }
            
            //System.out.println(rs);
        }catch(Exception e){
            System.out.println(e);
        }
    }
    
    //Códigos de testes
    //public static void Main (String[] args){
    //    view_table(connectDB());
    //    Request_value(connectDB(),"id_usuario","usuario",null,null);
    //}
}
