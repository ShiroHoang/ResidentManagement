/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HouseholdDAO;
import dal.HouseholdMemberDAO;
import dal.LogDAO;
import dal.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import model.Log;
import model.Registration;
import model.User;

/**
 *
 * @author huyng
 */
public class RequestProcessServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RequestProcessServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestProcessServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        RegistrationDAO registrations = new RegistrationDAO();
        HouseholdDAO households = new HouseholdDAO();
        HouseholdMemberDAO householdMember = new HouseholdMemberDAO();
        User user = (User) session.getAttribute("account");
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String formattedDate = today.format(formatter);
        LogDAO logs = new LogDAO();
        if (user == null) {
            response.sendRedirect("login");
        } else {
            String action = request.getParameter("action");
            int registrationId = Integer.parseInt(request.getParameter("registrationId"));
            Registration registration = registrations.getRegistrationById(registrationId);
            if (action.equalsIgnoreCase("deny")) {
                return;
            } else if (action.equalsIgnoreCase("accept") && registration.getRequestType().equalsIgnoreCase("registerAddress")) {
                int newAddressId = registrations.getNewAddressIdByRegistrationId(registrationId);
                int headOfHousehold = households.getHeadOfHouseholdIdByAddressId(newAddressId);
                if (headOfHousehold == -1 && registration.getRegistrationType().equalsIgnoreCase("permanent")) {
                    //Nếu không có chủ hộ khẩu mà user đăng ký dưới đơn thường trú -> user trở thành chủ hộ khẩu ->     
                    households.newHousehold(registration.getUserId(), newAddressId, formattedDate); //cho vào hộ khảu mới
                    int householdId = households.getHouseholdID(newAddressId, registration.getUserId()); // lấy id của hộ khẩu vừa mới thêm vào
                    householdMember.newHouseholdMember(householdId, registration.getUserId(), "Chủ hộ", registration.getRegistrationType()); //
                    logs.insertNewLog(new Log(user.getUserId(), "Duyệt đăng ký hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate));
                } else if (headOfHousehold == -1 && !registration.getRegistrationType().equalsIgnoreCase("permanent")) {
                    //trong truong hop ko co chu ho khau va don đăng ký không phải thường trú, vẫn duyệt, nhưng không lưu vào household, chỉ lưu vào householdMember
                    households.newHousehold(-1, newAddressId, formattedDate); //Thêm vào bảng household, tuy nhiên để null chủ hộ
                    int householdId = households.getHouseholdID(newAddressId);
                    householdMember.newHouseholdMember(householdId, registration.getUserId(), "Không có chủ hộ", registration.getRegistrationType()); //
                    logs.insertNewLog(new Log(user.getUserId(), "Duyệt đăng ký hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate));
                } else {
                    //trong trường hợp có chủ hộ khẩu và đơn dăng ký đủ điều kiện
                    int householdId = households.getHouseholdID(newAddressId, registration.getHeadOfHouseholdID()); // lấy id của hộ khẩu request
                    //thêm mới vào bảng householdmember
                    householdMember.newHouseholdMember(householdId, registration.getHeadOfHouseholdID(), registration.getRelationship(), registration.getRegistrationType());
                    logs.insertNewLog(new Log(user.getUserId(), "Duyệt đăng ký hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate));
                }

            }

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
