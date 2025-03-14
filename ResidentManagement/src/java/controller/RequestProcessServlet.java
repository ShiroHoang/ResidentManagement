/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.*;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import model.Household;
import model.HouseholdMember;
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
        int registrationId = Integer.parseInt(request.getParameter("registrationId"));
        RegistrationDAO rdb = new RegistrationDAO();
        UserDAO udb = new UserDAO();
        HouseholdDAO hdb = new HouseholdDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        HouseholdMemberDAO hmdb = new HouseholdMemberDAO();
        LogDAO logdb = new LogDAO();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String formattedDate = today.format(formatter);

        if (user == null) {
            response.sendRedirect("login");
        } else {
            String action = request.getParameter("action");
            Registration registration = rdb.getRegistrationById(registrationId);
            String requestType = request.getParameter("requestType");
            int userId = rdb.getUserIdByRegistrationId(registrationId);
            if (action.equalsIgnoreCase("deny")) {
                rdb.changeStatusToRejectedByRegistrationId(registrationId);
                Log log = new Log(userId, "Từ chối đơn chuyển hộ khẩu", formattedDate);
                logdb.insertNewLog(log);
                request.setAttribute("requestType", rdb.getRequestTypeByRegistrationId(registrationId));
                RequestDispatcher rs = request.getRequestDispatcher("RequestList");
                rs.forward(request, response);
            } else if (action.equalsIgnoreCase("approve") && requestType.equalsIgnoreCase("registerAddress")) {
                int headOfHouseholdId = rdb.getHeadOfHouseholdIdByRegistrationId(registrationId);
                int newAddressId = rdb.getNewAddressIdByRegistrationId(registrationId);
                int householdId = hdb.getHouseholdIDByAddressIdAndHeadOfHouseholdId(newAddressId, headOfHouseholdId); // lấy id của hộ khẩu request
                if (headOfHouseholdId == -1 && registration.getRegistrationType().equalsIgnoreCase("permanent")) {
                    rdb.changeStatusToApprovedByRegistrationId(registrationId, user.getUserId());
                    //Nếu không có chủ hộ khẩu mà user đăng ký dưới đơn thường trú -> user trở thành chủ hộ khẩu ->     
                    Household household = new Household(userId, newAddressId, formattedDate);
                    hdb.insertNewHousehold(household); //cho vào hộ khảu mới
                    HouseholdMember householdMember = new HouseholdMember(householdId, userId, "Chủ hộ",
                            rdb.getRegistrationTypeByRegistrationId(registrationId));
                    hmdb.insertNewHouseholdMember(householdMember);
                    logdb.insertNewLog(new Log(user.getUserId(), "Duyệt đăng ký hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate));
                } else if (headOfHouseholdId == -1 && !registration.getRegistrationType().equalsIgnoreCase("permanent")) {
                    //trong truong hop ko co chu ho khau va don đăng ký không phải thường trú, vẫn duyệt, nhưng không lưu vào household, chỉ lưu vào hmdb
//                    hdb.newHousehold(-1, newAddressId, formattedDate); //Thêm vào bảng household, tuy nhiên để null chủ hộ
//                    hmdb.newHouseholdMember(householdId, registration.getUserId(), "Không có chủ hộ", registration.getRegistrationType()); //
//                    logdb.insertNewLog(new Log(user.getUserId(), "Duyệt đăng ký hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate));
                } else {
                    //trong trường hợp có chủ hộ khẩu và đơn dăng ký đủ điều kiện           
                    rdb.changeStatusToApprovedByRegistrationId(registrationId, user.getUserId());
                    HouseholdMember householdMember = new HouseholdMember(householdId, userId, rdb.getRelationshipByRegistrationId(registrationId),
                            rdb.getRegistrationTypeByRegistrationId(registrationId));
                    hmdb.insertNewHouseholdMember(householdMember);
                    logdb.insertNewLog(new Log(user.getUserId(), "Duyệt đăng ký hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate));
                }
                //quay lại về
                request.setAttribute("requestType", rdb.getRequestTypeByRegistrationId(registrationId));
                RequestDispatcher rs = request.getRequestDispatcher("RequestList");
                rs.forward(request, response);

            } else if (action.equalsIgnoreCase("approve") && requestType.equalsIgnoreCase("moveAddress")) {
                rdb.changeStatusToApprovedByRegistrationId(registrationId, user.getUserId());
                int headOfHouseholdId = rdb.getHeadOfHouseholdIdByRegistrationId(registrationId);
                int newAddressId = rdb.getNewAddressIdByRegistrationId(registrationId);
                hmdb.deleteHouseholdMemberByUserId(userId);
                if (headOfHouseholdId == -1) { //không tìm thấy chủ hộ và thì phải có trạng thái đăng ký thường trú 
                    Household household = new Household(userId, newAddressId, formattedDate); //tạo chủ hộ mới
                    hdb.insertNewHousehold(household);

                    HouseholdMember householdMember = new HouseholdMember(hdb.getHouseholdIDByAddressIdAndHeadOfHouseholdId(newAddressId, userId),
                            userId, "Chủ hộ", rdb.getRegistrationTypeByRegistrationId(registrationId));
                    hmdb.insertNewHouseholdMember(householdMember);
                } else {
                    HouseholdMember householdMember = new HouseholdMember(hdb.getHouseholdIDByAddressIdAndHeadOfHouseholdId(newAddressId, headOfHouseholdId),
                            userId, rdb.getRelationshipByRegistrationId(registrationId),
                            rdb.getRegistrationTypeByRegistrationId(registrationId));
                    hmdb.insertNewHouseholdMember(householdMember);
                }

                Log log = new Log(userId, "Duyệt đơn chuyển hộ khẩu mới cho đơn số " + registration.getRegistrationId(), formattedDate);
                logdb.insertNewLog(log);
                request.setAttribute("requestType", rdb.getRequestTypeByRegistrationId(registrationId));
                RequestDispatcher rs = request.getRequestDispatcher("RequestList");
                rs.forward(request, response);
            } else if (action.equalsIgnoreCase("approve") && requestType.equalsIgnoreCase("separateAddress")) {
                //get permanent householdmem
                HouseholdMember householdMember = hmdb.getPermanentHouseholdMemberbyUserId(userId);
                //old household info
                Household oldHousehold = hdb.getHouseholdById(householdMember.getHouseholdId());

                hmdb.deletePermanentHouseholdMemberByID(userId);
                hdb.insertHousehold(userId, oldHousehold.getAddressId(), formattedDate);

                Household newHousehold = hdb.getHouseholdByHeadId(userId);
                hmdb.insertHouseholdMember(newHousehold.getHouseholdId(), userId, "Chủ hộ", "permanent");
                rdb.updateRegistrationStatus(registrationId, "Approved", ((User) session.getAttribute("account")).getUserId());
                Log log = new Log(user.getUserId(), "Duyệt đơn tách hộ khẩu", formattedDate);
                logdb.insertNewLog(log);
                request.setAttribute("registration", registration);
                request.setAttribute("message", "Duyệt đơn thành công");
                RequestDispatcher rs = request.getRequestDispatcher("view/viewListDetail.jsp");
                rs.forward(request, response);
                return;
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
