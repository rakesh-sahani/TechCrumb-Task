package task;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Connect {

    static Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Connect() {
    }

    public static Connection makeConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://sql12.freemysqlhosting.net:3306/sql12235777?user=sql12235777&password=9FbctMhnLq";
            con = DriverManager.getConnection(url);
            System.out.println("connection  build");
        } catch (Exception e) {
            System.out.println(e);
            System.out.println("connection not build");
        }
        return con;
    }

    public static void CloseConnection() throws Exception {
        if (con != null) {
            con.close();
        }
    }
}
