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
}
