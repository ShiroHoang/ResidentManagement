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
import model.Log;

/**
 *
 * @author huyng
 */
public class LogDAO extends DBContext {

    public List<Log> getAll() {
        String sql = "select * from Logs";
        try {
            List<Log> list = new ArrayList<>();
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Log(rs.getInt("LogID"), rs.getInt("UserID"), rs.getString("Action"), rs.getString("Timestamp")));
            }
            return list;
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return null;
    }

    public void insertNewLog(Log log) {
        String sql = "insert into Logs(UserID, Action, Timestamp) values(?,?,?)";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, log.getUserId());
            stmt.setString(2, log.getAction());
            stmt.setString(3, log.getTimestamp());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }
}
