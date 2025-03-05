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
import java.util.logging.Level;
import model.*;

/**
 *
 * @author huyng
 */
public class AddressRegistryDAO extends DBContext {

    public List<AddressRegistry> getAll() {
        String sql = "select * from AddressRegistry";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            List<AddressRegistry> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new AddressRegistry(rs.getInt("AddressID"), rs.getString("Province"),
                        rs.getString("City"), rs.getString("District"), rs.getString("Ward"),
                        rs.getString("Street"), rs.getString("HouseNumber")));
                ;
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public boolean checkAddressRegistry(AddressRegistry addressRegistry) {
        String sql = """
                     select * from AddressRegistry where
                     Province = ? and 
                     City = ? and 
                     District = ? and 
                     Ward = ? and 
                     Street = ? and
                     HouseNumber = ?
                     """;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, "N'" + addressRegistry.getProvince() + "'");
            stmt.setString(2, "N'" + addressRegistry.getCity() + "'");
            stmt.setString(3, "N'" + addressRegistry.getDistrict() + "'");
            stmt.setString(4, "N'" + addressRegistry.getWard() + "'");
            stmt.setString(5, "N'" + addressRegistry.getStreet() + "'");
            stmt.setString(6, "N'" + addressRegistry.getHouseNumber() + "'");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return true;
            }
            return false;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public void insertNewAddressRegistry(AddressRegistry addressRegistry) {
        try {
            String sql = "insert into AddressRegistry(Province, City, District, Ward, Street, HouseNumber) values(?,?,?,?,?,?)";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, addressRegistry.getProvince());
            stmt.setString(2, addressRegistry.getCity());
            stmt.setString(3, addressRegistry.getDistrict());
            stmt.setString(4, addressRegistry.getWard());
            stmt.setString(5, addressRegistry.getStreet());
            stmt.setString(6, addressRegistry.getHouseNumber());
            stmt.executeUpdate();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public int getAddressId(AddressRegistry addressRegistry) {
        try {
            String sql = """
                     SELECT AddressID FROM AddressRegistry WHERE 
                     Province = ? AND City = ? AND District = ? 
                     AND Ward = ? AND Street = ? AND HouseNumber = ?
                     """;
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, addressRegistry.getProvince());
            stmt.setString(2, addressRegistry.getCity());
            stmt.setString(3, addressRegistry.getDistrict());
            stmt.setString(4, addressRegistry.getWard());
            stmt.setString(5, addressRegistry.getStreet());
            stmt.setString(6, addressRegistry.getHouseNumber());

            ResultSet rs = stmt.executeQuery();

            // If an address is found, return its ID
            if (rs.next()) {
                return rs.getInt("AddressID");
            }

            // If no match is found, return -1
            return -1;

        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
            return -1;
        }
    }
}
