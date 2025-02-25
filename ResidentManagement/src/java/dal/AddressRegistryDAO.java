/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import model.*;

/**
 *
 * @author huyng
 */
public class AddressRegistryDAO extends DBContext {
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
            System.out.println(ex.getMessage());
        }
        return null;

    }
}
