/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Registration;
import dal.RegistrationDAO;
import dal.HouseholdMemberDAO;
import model.HouseholdMember;
import dal.HouseholdDAO;
import jakarta.servlet.RequestDispatcher;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import model.Log;
import dal.LogDAO;
import model.Household;

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
        String action = request.getParameter("action");
        String requestType = request.getParameter("requestType");
        Integer approveByObj = (Integer) request.getSession().getAttribute("approveBy");

        RegistrationDAO rdb = new RegistrationDAO();
        HouseholdMemberDAO hmdb = new HouseholdMemberDAO();
        HouseholdDAO hdb = new HouseholdDAO();
        LogDAO logdb = new LogDAO();

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String formattedDate = today.format(formatter);

        if (approveByObj != null) {
            int approveBy = approveByObj;
            if (action.equals("approve")) {
                rdb.changeStatusToApprovedByRegistrationId(registrationId, approveBy);
                int userId = rdb.getUserIdByRegistrationId(registrationId);
                int headOfHouseholdId = rdb.getHeadOfHouseholdIdByRegistrationId(registrationId);
                int newAddressId = rdb.getNewAddressIdByRegistrationId(registrationId);
                if (requestType.equals("moveAddress")) {
                    hmdb.deleteHouseholdMemberByUserId(userId);
                    if (headOfHouseholdId == -1) {
                        Household household = new Household(userId, newAddressId, formattedDate);
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

                    Log log = new Log(userId, "Đồng ý đơn chuyển hộ khẩu", formattedDate);
                    logdb.insertNewLog(log);
                    request.setAttribute("requestType", requestType);
                    RequestDispatcher rs = request.getRequestDispatcher("RequestList");
                    rs.forward(request, response);
                }
            } else if (action.equals("deny")) {
                rdb.changeStatusToRejectedByRegistrationId(registrationId);
                int userId = rdb.getUserIdByRegistrationId(registrationId);
                Log log = new Log(userId, "Từ chối đơn chuyển hộ khẩu", formattedDate);
                logdb.insertNewLog(log);
                request.setAttribute("requestType", requestType);
                RequestDispatcher rs = request.getRequestDispatcher("RequestList");
                rs.forward(request, response);
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
        //processRequest(request, response);
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
