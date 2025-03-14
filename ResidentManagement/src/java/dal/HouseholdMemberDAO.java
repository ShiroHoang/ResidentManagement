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
import model.User;

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
    
    public List<HouseholdMember> getHouseholdMemberByUserId(int userId) {
        String sql = "select * from HouseholdMembers where UserId = ?";
        try {
            List<HouseholdMember> list = new ArrayList<>();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new HouseholdMember(rs.getInt("MemberId"), rs.getInt("HouseholdID"), rs.getInt("UserId"), rs.getString("Relationship"), rs.getString("TypeStay")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }
    
    
    public HouseholdMember getPermanentHouseholdMemberbyUserId(int userid) {
        List<HouseholdMember> list = this.getHouseholdMemberByUserId(userid);
        for (HouseholdMember householdMember : list) {
            if (householdMember.getTypeStay().equals("permanent"))
                return householdMember;
        }
        return null;
    }

    //xoa ho khau thuong tru
    public void deletePermanentHouseholdMemberByID(int memberID) {
        String sql = "delete from HouseholdMembers where UserId = ? and TypeStay='permanent'";
        try {
            List<HouseholdMember> list = new ArrayList<>();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, memberID);
            stmt.executeUpdate();            
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    public void insertHouseholdMember(int householdId, int userId, String relationship, String typeStay) {
        String sql = "insert into HouseholdMembers(HouseholdID, UserId, Relationship, TypeStay) values(?, ?, ?, ?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);            
            stmt.setInt(1, householdId);
            stmt.setInt(2, userId);
            stmt.setString(3, relationship);
            stmt.setString(4, typeStay);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
    
    
    public int findPermanentHouseHoldId(User user) {
        String sql = "select * from Households hh "
                + "join HouseholdMembers hhm on hh.HouseholdID = hhm.HouseholdID "
                + "where UserID = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("TypeStay").equals("permanent")) {
                    return rs.getInt("HouseholdID");
                }
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }
    //check if a user already has permanent resident

    public boolean existTypeStayPermanentOfMember(User user) {
        String sql = "select * from HouseholdMembers where UserID = ? and TypeStay = 'permanent'";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, user.getUserId());
            ResultSet rs = stmt.executeQuery();

            String typeStay = "";
            while (rs.next()) {
                typeStay = rs.getString("TypeStay");
            }
            return !typeStay.isEmpty();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return false;
    }

    public int existHeadOfHouseholdId(String fullname) {
        String sql = """
                     select h.HeadOfHouseholdID
                     from Households h
                     left join Users u on h.HeadOfHouseholdID = u.UserID
                     where u.FullName = ?
                     """;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, fullname);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return rs.getInt("HeadOfHouseholdID");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }


    public void deleteHouseholdMemberByUserId(int userId) {
        String sql = """
                     delete from HouseholdMembers where UserID = ?
                     """;
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

    }

    public void insertNewHouseholdMember(HouseholdMember householdMember){
        String sql = """
                     insert into HouseholdMembers(HouseholdID, UserID, Relationship, TypeStay) values(?, ?, ?, ?)
                     """;
         try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, householdMember.getHouseholdId());
            stmt.setInt(2, householdMember.getUserId());
            stmt.setString(3, householdMember.getRelationship());
            stmt.setString(4, householdMember.getTypeStay());
            
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
