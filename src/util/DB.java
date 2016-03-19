package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {
	
	static {//ʹ�þ�̬���������ÿ�ζ�Ҫ��������
		try {
			Class.forName("com.mysql.jdbc.Driver");//��������
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	DB(){}
	
	public static Connection getConn(){
		Connection conn=null;
	
		try {			
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","123456");
		//	conn.setCatalog("test");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void closeConn(Connection conn) {
		if(conn!=null){
			try {
				conn.close();
				conn=null;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}
	}
	
	
	public static Statement getStmt(Connection conn){
		Statement stmt=null;
	
		try {
		    stmt=conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stmt;
	}
	
	public static Statement getStmt(Connection conn,int resultSetType, int resultSetConcurrency){
		Statement stmt=null;
	
		try {
		    stmt=conn.createStatement(resultSetType,resultSetConcurrency);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stmt;
	}
	
	public static void closeStmt(Statement stmt) {
		if(stmt!=null){
			try {
				stmt.close();
				stmt=null;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}
	}
	
	
	
	public static PreparedStatement getPStmt(Connection conn,String sql){
		PreparedStatement pStmt=null;
	
		try {
			pStmt=conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pStmt;
	}
	
	
	public static PreparedStatement getPStmt(Connection conn,String sql,int autoGeneratedKeys){
		PreparedStatement pStmt=null;
	
		try {
			pStmt=conn.prepareStatement(sql,autoGeneratedKeys);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pStmt;
	}
	
	public static void closePStmt(PreparedStatement pStmt) {
		if(pStmt!=null){
			try {
				pStmt.close();
				pStmt=null;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}
	}
	
	
	public static ResultSet excuteQuery(Statement stmt,String sql){
		ResultSet rs=null;
	
		try {
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
		public static ResultSet excuteQuery(Connection conn,String sql){
			ResultSet  rs=null;
		
			try {
				rs=conn.createStatement().executeQuery(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return rs;
		}

		public static void closeRs(ResultSet rs) {
			if(rs!=null){
				try {
					rs.close();
					rs=null;
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}		
			}
		}
	
	public  static void excuteUpdate(Connection conn,String sql) throws SQLException{

				conn.createStatement().executeUpdate(sql);

	}

}