/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.AddressRegistry;
import model.Household;

/**
 *
 * @author huyng
 */
public class HouseholdDAO extends DBContext {

    public List<Household> getAll() {
        String sql = "select * from Households";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            List<Household> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new Household(rs.getInt("HouseholdID"),
                        rs.getInt("HeadOfHouseholdID"), rs.getInt("AddressID"), rs.getString("CreatedDate")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public int getHeadOfHouseHoldByHouseHoldId(int householdId) {
        String sql = "select * from Households where householdId = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, householdId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt("HeadOfHouseholdID");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public int getAddressIdByHouseHoldId(int householdId) {
        String sql = "select * from Households where householdId = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, householdId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt("AddressID");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public int getHouseholdIDByAddressIdAndHeadOfHouseholdId(int addressID, int headOfHouseholdId) {
        String sql = "select * from Households where AddressID = ? and HeadOfHouseholdID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, addressID);
            stmt.setInt(2, headOfHouseholdId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt("HouseholdID");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }
    
    public int getHouseholdID(int addressID) {
        String sql = "select * from Households where AddressID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, addressID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt("HouseholdID");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public ArrayList<Integer> getHeadOfHouseholdIdByAddressId(int addressId) {
        String sql = """
                 SELECT Households.HeadOfHouseholdID 
                 FROM Households WHERE AddressID = ?
                 """;
        ArrayList<Integer> headOfHouseholdIds = new ArrayList<>();
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, addressId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                headOfHouseholdIds.add(rs.getInt("HeadOfHouseholdID"));
            }
            return headOfHouseholdIds;
        } catch (SQLException ex) {
            System.out.println("SQL Error: " + ex.getMessage());
        }
        return null;
    }
    
    public void insertNewHousehold(Household household){
        String sql = """
                     insert into Households(HeadOfHouseholdID, AddressID, CreatedDate) values(?, ?, ?)
                     """;
         try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, household.getHeadOfHouseholdId());
            stmt.setInt(2, household.getAddressId());
            stmt.setString(3, household.getCreatedDate());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

}
