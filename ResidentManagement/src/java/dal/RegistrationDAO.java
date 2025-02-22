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
public class RegistrationDAO extends DBContext{
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
    
    public void newRegistration(){
        String sql = "insert into Registrations values(?,?)";
    }
}
