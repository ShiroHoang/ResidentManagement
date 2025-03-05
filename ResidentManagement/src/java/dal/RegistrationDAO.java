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
public class RegistrationDAO extends DBContext {

    public List<Registration> getAll() {
        String sql = "select * from Registrations";
        try {
            List<Registration> list = new ArrayList<>();
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Registration(rs.getInt("RegistrationID"), rs.getInt("UserID"), rs.getString("RegistrationType"),
                        rs.getString("StartDate"), rs.getString("EndDate"), rs.getString("Status"), rs.getInt("ApprovedBy"), rs.getString("Comments")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public void newRegistrationRegisterAddress(User user, String registrationType, String startDate, int addressID, String requestType) {
        String sql = "insert into Registrations(UserID, RegistrationType, StartDate, NewAddressID, RequestType) values(?,?,?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            stmt.setString(2, registrationType);
            stmt.setString(3, startDate);
            stmt.setInt(4, addressID);
            stmt.setString(5, requestType);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void newRegistrationMovedAddress(User user, String registrationType, String startDate, int oldAddressID, int newAddressID, String requestType) {
        String sql = "insert into Registrations(UserID, RegistrationType, StartDate, OldAddressID, NewAddressID, RequestType) values(?,?,?,?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            stmt.setString(2, registrationType);
            stmt.setString(3, startDate);
            stmt.setInt(4, oldAddressID);
            stmt.setInt(5, newAddressID);
            stmt.setString(6, requestType);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public void newRegistrationSeparateAddress(User user, String registrationType,String startDate, int newAddressID, int HeadOfHouseholdID, String requestType) {
        String sql = "insert into Registrations(UserID, RegistrationType, StartDate, NewAddressID, HeadOfHouseholdID, RequestType) values(?,?,?,?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            stmt.setString(2, registrationType);
            stmt.setString(3, startDate);
            stmt.setInt(4, newAddressID);
            stmt.setInt(5, HeadOfHouseholdID);
            stmt.setString(6, requestType);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public List<Registration> filterRegistrationByUserID(User user) {
        String sql = "select * from Registrations where UserID = ?";
        try {
            List<Registration> list = new ArrayList<>();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Registration(rs.getInt("RegistrationID"), rs.getInt("UserID"), rs.getString("RegistrationType"),
                        rs.getString("StartDate"), rs.getString("EndDate"), rs.getString("Status"), rs.getInt("ApprovedBy"), rs.getString("Comments")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }
    
}
