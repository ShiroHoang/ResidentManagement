/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HouseholdDAO;
import dal.HouseholdMemberDAO;
import dal.LogDAO;
import dal.RegistrationDAO;
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
import model.Log;
import model.Registration;
import model.User;

/**
 *
 * @author huyng
 */
public class RequestCommentServlet extends HttpServlet {

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
            out.println("<title>Servlet RequestCommentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestCommentServlet at " + request.getContextPath() + "</h1>");
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
        RegistrationDAO rdb = new RegistrationDAO();
        HouseholdDAO hdb = new HouseholdDAO();
        HouseholdMemberDAO hmdb = new HouseholdMemberDAO();
        User user = (User) session.getAttribute("account");
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String formattedDate = today.format(formatter);
        LogDAO logdb = new LogDAO();
        if (user == null) {
            response.sendRedirect("login");
        } else {
            int registrationId = Integer.parseInt(request.getParameter("registrationId"));
            Registration registration = rdb.getRegistrationById(registrationId);
            String comment = request.getParameter("comment");
            rdb.newCommentByRegistrationId(registrationId, comment);
            Log log = new Log(user.getUserId(), "Nhận xét đơn " + registration.getRegistrationId(), formattedDate);
            logdb.insertNewLog(log);
            request.setAttribute("requestType", rdb.getRequestTypeByRegistrationId(registrationId));
            request.setAttribute("message", "Nhận xét thành công");
            request.setAttribute("registration", registration);
            RequestDispatcher rs = request.getRequestDispatcher("view/viewListDetail.jsp");
            rs.forward(request, response);
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
