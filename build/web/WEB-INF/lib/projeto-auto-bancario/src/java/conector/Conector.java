
package conector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;

public class Conector {
    
    Connection con = null;

    public Conector(){
    }
    
    public static Connection connectDB(){
        try{
            Class.forName("org.sqlite.JDBC");
            Connection con = DriverManager.getConnection("jdbc:sqlite:C:\\Users\\Mary\\Documents\\GitHub\\finac.db");
            System.out.println("Conexao bem sucedida");

            return con;
        }catch(Exception e){
            System.out.println("Conexao falhou: "+e);
            return null;
        }
    }
    
    public static void insert_transaction(Connection con){
        String query = "insert into transacao (vl_valor,nm_tipo,dt_data,id_usuario) values ()";
    }
    
    public static ArrayList<String> Request_value(Connection con, String what, String table, String condition){
        ArrayList<String> value = new ArrayList<String>();
        String query = "";
        if (condition != null){
            query = "Select "+what+" from "+table+" where "+condition;
        }else{
            query = "Select "+what+" from "+table;
        }
        
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
    
    //public static void Main (String[] args){
    //    view_table(connectDB());
    //    Request_value(connectDB(),"id_usuario","usuario",null,null);
    //}
}
