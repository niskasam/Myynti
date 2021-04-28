package model.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Myynti;

public class Dao {
	private Connection con=null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep=null; 
	private String sql;
	private String db ="Myynti.sqlite";
	
	private Connection yhdista(){
    	Connection con = null;    	
    	String path = System.getProperty("catalina.base");    	
    	path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/");
    	String url = "jdbc:sqlite:"+path+db;    	
    	try {	       
    		Class.forName("org.sqlite.JDBC");
	        con = DriverManager.getConnection(url);	
	        System.out.println("Yhteys avattu.");
	     }catch (Exception e){	
	    	 System.out.println("Yhteyden avaus epäonnistui.");
	        e.printStackTrace();	         
	     }
	     return con;
	}
	
	public ArrayList<Myynti> listaaAsiakkaat(){
		ArrayList<Myynti> asiakkaat = new ArrayList<Myynti>();
		sql = "SELECT * FROM asiakkaat";
		
		try {
			con=yhdista();
			if(con!=null) {
				stmtPrep = con.prepareStatement(sql);
				rs = stmtPrep.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						Myynti myynti = new Myynti();
						myynti.setAsiakas_id(rs.getInt(1));
						myynti.setEtunimi(rs.getString(2));
						myynti.setSukunimi(rs.getString(3));
						myynti.setPuhelin(rs.getString(4));
						myynti.setSposti(rs.getString(5));
						asiakkaat.add(myynti);
					
					}
				}
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	
	
	public ArrayList<Myynti> listaaKaikki(String hakusana){
		ArrayList<Myynti> asiakkaat = new ArrayList<Myynti>();
		sql = "SELECT * FROM asiakkaat WHERE asiakas_id LIKE ? OR etunimi LIKE ? OR sukunimi LIKE ? OR puhelin LIKE ? OR SPOSTI LIKE ?";
		
		try {
			con=yhdista();
			if(con!=null) {
				stmtPrep = con.prepareStatement(sql);
				stmtPrep.setString(1, "%" + hakusana + "%");
				stmtPrep.setString(2, "%" + hakusana + "%");
				stmtPrep.setString(3, "%" + hakusana + "%");
				stmtPrep.setString(4, "%" + hakusana + "%");
				stmtPrep.setString(5, "%" + hakusana + "%");
				rs = stmtPrep.executeQuery();
				if(rs!=null) {
					while(rs.next()) {
						Myynti myynti = new Myynti();
						myynti.setAsiakas_id(rs.getInt(1));
						myynti.setEtunimi(rs.getString(2));
						myynti.setSukunimi(rs.getString(3));
						myynti.setPuhelin(rs.getString(4));
						myynti.setSposti(rs.getString(5));
						asiakkaat.add(myynti);
					
					}
				}
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakkaat;
	}
	
	public boolean lisaaAsiakas(Myynti myynti) {
		boolean paluuArvo=true;
		sql="INSERT INTO asiakkaat VALUES (?,?,?,?,?)";
		try {
			con=yhdista();
			stmtPrep=con.prepareStatement(sql);
			stmtPrep.setInt(1, myynti.getAsiakas_id());
			stmtPrep.setString(2, myynti.getEtunimi());
			stmtPrep.setString(3, myynti.getSukunimi());
			stmtPrep.setString(4, myynti.getPuhelin());
			stmtPrep.setString(5, myynti.getSposti());
			stmtPrep.executeUpdate();
			con.close();
		} catch(Exception e) {
			e.printStackTrace();
			paluuArvo=false;
		}
		return paluuArvo;
	}
	
	public boolean poistaAsiakas(String poistettavaAsiakas) {
		
		boolean paluuArvo=true;
		
		sql="DELETE FROM asiakkaat WHERE asiakas_id = ?";
		try {
			con=yhdista();
			stmtPrep=con.prepareStatement(sql);
			stmtPrep.setString(1, poistettavaAsiakas);
			stmtPrep.executeUpdate();
			con.close();
			
		} catch(Exception e) {
			e.printStackTrace();
			paluuArvo=false;
		}
		
		return paluuArvo;
	}
	
}