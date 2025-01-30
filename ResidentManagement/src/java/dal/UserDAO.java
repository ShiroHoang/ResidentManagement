/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;


import model.User;
import java.sql.*;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author huyng
 */
public class UserDAO extends DBContext {
    
    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    
    public User getAccount(String user, String pass) {
        String sql = "select * from customer where "
                + "username =? and password = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, user);
            stmt.setString(2, pass);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("UserId"),rs.getString("FullName"), rs.getString("Email"), rs.getString("Password"), rs.getString("Role"),rs.getString("Address"));
            }
        } catch (SQLException ex) {
            logger.log(Level.SEVERE,"An error occured during getting the user account", ex);
        }
        return null;
        
    }
    
}
