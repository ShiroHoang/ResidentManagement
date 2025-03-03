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
import model.Household;
import model.HouseholdMember;

/**
 *
 * @author huyng
 */
public class HouseholdMemberDAO extends DBContext {

    public List<HouseholdMember> getAll() {
        String sql = "select * from HouseholdMembers";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            List<HouseholdMember> list = new ArrayList<>();
            while (rs.next()) {
                list.add(new HouseholdMember(rs.getInt("MemberID"),
                        rs.getInt("HouseholdID"), rs.getInt("UserID"), rs.getString("Relationship"), rs.getString("TypeStay")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }
}
