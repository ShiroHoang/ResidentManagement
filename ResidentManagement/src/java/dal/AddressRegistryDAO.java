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
}
