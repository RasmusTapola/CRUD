package model.dao;


	import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.util.ArrayList;
	import model.Vene;

	public class Dao {
		private Connection con = null;
		private ResultSet rs = null;
		private PreparedStatement stmtPrep=null;
		private String sql;
		private String db ="Venekanta.sqlite";
		
		
		
		private Connection yhdista() {
			Connection con = null;
			String url ="jdbc:sqlite:C:/Users/Uusio/eclipse-workspace/"+ db;
			try {
				Class.forName("org.sqlite.JDBC");
				con = DriverManager.getConnection(url);
				System.out.println("Yhteys muodostettu");
			}catch (Exception e) {
				System.out.println("Yhteys epäonnistui");
				e.printStackTrace();
			}
			return con;
		}
		
		public ArrayList<Vene> listaaKaikki(){
			ArrayList<Vene> veneet = new ArrayList<Vene>();
			sql = "SELECT * FROM veneet";
			try {
				con=yhdista();
				if(con!=null) {
					stmtPrep = con.prepareStatement(sql);
					rs=stmtPrep.executeQuery();
					if(rs!=null) {
						while (rs.next()) {
							Vene vene = new Vene();
							vene.setTunnus(rs.getInt(1));
							vene.setNimi(rs.getString(2));
							vene.setMerkkimalli(rs.getString(3));
							vene.setPituus(rs.getDouble(4));
							vene.setLeveys(rs.getDouble(5));
							vene.setHinta(rs.getInt(6));
							veneet.add(vene);
						}
					}
				}
				con.close();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return veneet;
		
		}
		public ArrayList<Vene> listaaKaikki(String hakusana){
			ArrayList<Vene> veneet = new ArrayList<Vene>();
			sql = "SELECT * FROM Veneet WHERE nimi LIKE ? or merkkimalli LIKE ?";      
			try {
				con=yhdista();
				if(con!=null){
					stmtPrep = con.prepareStatement(sql);
					stmtPrep.setString(1, "%" + hakusana + "%");
					stmtPrep.setString(2, "%" + hakusana + "%");  
	        		rs = stmtPrep.executeQuery();   
					if(rs!=null){				
						while(rs.next()){
							Vene vene = new Vene();
							vene.setTunnus(rs.getInt(1));
							vene.setNimi(rs.getString(2));
							vene.setMerkkimalli(rs.getString(3));
							vene.setPituus(rs.getDouble(4));
							vene.setLeveys(rs.getDouble(5));
							vene.setHinta(rs.getInt(6));
							veneet.add(vene);
						}					
					}				
				}	
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}		
			return veneet;
		}
		public boolean lisaaVene(Vene vene){
			boolean paluuArvo=true;
			sql="INSERT INTO veneet(nimi, merkkimalli, pituus, leveys, hinta) VALUES(?,?,?,?,?)";						  
			try {
				con = yhdista();
				stmtPrep=con.prepareStatement(sql); 
				stmtPrep.setString(1, vene.getNimi());
				stmtPrep.setString(2, vene.getMerkkimalli());
				stmtPrep.setDouble(3, vene.getPituus());
				stmtPrep.setDouble(4, vene.getLeveys());
				stmtPrep.setInt(5, vene.getHinta());
				stmtPrep.executeUpdate();
		        con.close();
			} catch (Exception e) {				
				e.printStackTrace();
				paluuArvo=false;
			}				
			return paluuArvo;
		}
		
		public boolean poistaVene(int tunnus){ 
			boolean paluuArvo=true;
			sql="DELETE FROM veneet WHERE tunnus=?";						  
			try {
				con = yhdista();
				stmtPrep=con.prepareStatement(sql); 
				stmtPrep.setInt(1, tunnus);			
				stmtPrep.executeUpdate();
		        con.close();
			} catch (Exception e) {				
				e.printStackTrace();
				paluuArvo=false;
			}				
			return paluuArvo;
		}	
		
		public Vene etsiVene(String nimi) {
			Vene vene = null;
			sql = "SELECT * FROM veneet WHERE nimi=?";
			try {
				con=yhdista();
				if(con!=null) {
					stmtPrep= con.prepareStatement(sql);
					stmtPrep.setString(1, nimi);
					rs = stmtPrep.executeQuery();
					if(rs.isBeforeFirst()) {
						rs.next();
						vene= new Vene();
						vene.setTunnus(rs.getInt(1));
						vene.setNimi(rs.getString(2));
						vene.setMerkkimalli(rs.getString(3));
						vene.setPituus(rs.getDouble(4));
						vene.setLeveys(rs.getDouble(5));
						vene.setHinta(rs.getInt(6));
					}
					con.close();
				}
			}catch (Exception e) {
					e.printStackTrace();
				}
			return vene;
		}
		public boolean muutaVene(Vene vene){
			boolean paluuArvo=true;
			sql="UPDATE veneet SET nimi=?, merkkimalli=?, pituus=?, leveys=?, hinta=? WHERE nimi=?";						  
			try {
				con = yhdista();
				stmtPrep=con.prepareStatement(sql); 
				stmtPrep.setString(1, vene.getNimi());
				stmtPrep.setString(2, vene.getMerkkimalli());
				stmtPrep.setDouble(3, vene.getPituus());
				stmtPrep.setDouble(4, vene.getLeveys());
				stmtPrep.setInt(5, vene.getHinta());
				stmtPrep.setInt(6, vene.getTunnus());
				stmtPrep.executeUpdate();
		        con.close();
			} catch (Exception e) {				
				e.printStackTrace();
				paluuArvo=false;
			}				
			return paluuArvo;
		}
	}