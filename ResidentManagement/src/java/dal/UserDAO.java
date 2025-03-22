/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.*;
import java.util.logging.Logger;
import java.util.logging.Level;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author huyng
 */
public class UserDAO extends DBContext {

    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

     public ArrayList<User> getAll() {
        String sql = "select * from Users";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            ArrayList<User> list = new ArrayList<>();
            String roleVN = null;
            while (rs.next()) {
                if (rs.getString("Role").equalsIgnoreCase("Citizen")) {
                    roleVN = new String("Dân thường");
                } else if (rs.getString("Role").equalsIgnoreCase("Police")) {
                    roleVN = new String("Công An");
                }  else if (rs.getString("Role").equalsIgnoreCase("AreaLeader")) {
                    roleVN = new String("Tổ trưởng khu phố");
                }


                list.add(new User(rs.getInt("UserID"),
                        rs.getString("FullName"), rs.getString("Email"), rs.getString("Password"), roleVN, rs.getString("Address"), rs.getString("PhoneNumber")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public ArrayList<User> getUserByStartAndEnd(ArrayList<User> users, int start, int end) {
        //This function return list of users which first is number 'start' and last with number 'end' of original list
        //Pagination
        ArrayList<User> list = new ArrayList<>();
        int last = end;
        if (end > users.size()) last = users.size();
        for (int i = start; i < last; i++) {
            list.add(users.get(i));
        }
        return list;
    }
    
    public User getAccount(String user, String pass) {
        String sql = "select * from Users where "
                + "Email =? and Password = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user);
            stmt.setString(2, pass);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("UserId"), rs.getString("FullName"),
                        rs.getString("Email"), rs.getString("Password"), rs.getString("Role"), rs.getString("Address"), rs.getString("PhoneNumber")
                );
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
        return null;

    }

    public void updateAccount(int userId, String FullName, String Email, String phone) {
        String sql = "update Users set FullName = ?, Email = ?, PhoneNumber = ? where UserID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, FullName);
            stmt.setString(2, Email);
            stmt.setString(3, phone);
            stmt.setInt(4, userId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
    }

     public void updateAccountByPolice(int userId, String FullName, String role, String phone) {
        String sql = "update Users set FullName = ?, Role = ?, PhoneNumber = ? where UserID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, FullName);
            stmt.setString(2, role);
            stmt.setString(3, phone);
            stmt.setInt(4, userId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
    }
    
    public User getUserById(int userId) {
        String sql = "select * from Users where userId = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs;
            rs = stmt.executeQuery();
            while(rs.next()){
                return new User(rs.getInt("UserId"),rs.getString("FullName"), rs.getString("Email"),
                        rs.getString("Password"), rs.getString("Role"), rs.getString("Address"), rs.getString("PhoneNumber"));
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
        return null;
    }
    
    public User getUserByNamePhoneAndEmail(String fullName, String email, String phoneNum) {
        String sql = "select * from Users where  FullName = ? and Email = ? and PhoneNumber = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, phoneNum);
            ResultSet rs;
            rs = stmt.executeQuery();
            while(rs.next()){
                return new User(rs.getInt("UserId"),rs.getString("FullName"), rs.getString("Email"),
                        rs.getString("Password"), rs.getString("Role"), rs.getString("Address"), rs.getString("PhoneNumber"));
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
        return null;
    }
    
    public void updateAccountPassword(int userId, String password) {
        String sql = "update Users set Password = ? where UserID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, password);
            stmt.setInt(2, userId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
    }

    
    public boolean checkIfExistedEmail(String email) {
        String sql = "select * from Users where Email = ?";
        User user = null;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);          
            stmt.setString(1, email);
            ResultSet rs;
            rs = stmt.executeQuery();
            while(rs.next()){
                user = new User(rs.getInt("UserId"),rs.getString("FullName"), rs.getString("Email"),
                        rs.getString("Password"), rs.getString("Role"), rs.getString("Address"), rs.getString("PhoneNumber"));
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
        
        return user != null;
    }
    
    public void insertAccount(String name, String email, String password, String role, String phoneNum, String address) {
        String sql = "insert into Users(Email, Password, Role, PhoneNumber, Address, FullName) values(?, ?, ?, ?, ?, ?)";
        
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setString(3,  role);
            stmt.setString(4, phoneNum);
            stmt.setString(5, address);
            stmt.setString(6, name);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
    }
    
    public String getFullNameByUserId(int userId){
        String sql = """
                     select Users.FullName 
                     from Users join Registrations on Registrations.UserID = Users.UserID
                     where Users.UserID = ?
                     """;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                return rs.getString("FullName");
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
        return null;
    }
    
    public String getNameByOnlyUserId(int userId){
        String sql = """
                     select Users.FullName 
                     from Users 
                     where Users.UserID = ?
                     """;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                return rs.getString("FullName");
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "An error occured during getting the user account", ex);
        }
        return null;
    }
    

}
