/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HouseholdDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dal.RegistrationDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Registration;
import model.User;
import dal.RegistrationDAO;
import dal.HouseholdMemberDAO;
import model.HouseholdMember;

/**
 *
 * @author HP
 */
public class RequestListServlet extends HttpServlet {

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
            out.println("<title>Servlet RequestListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RequestListServlet at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        RegistrationDAO rdb = new RegistrationDAO();
        //for view detail of list
        String action = request.getParameter("action");
        if (action != null && action.equals("view")) {
            Registration registration = rdb.getRegistrationById(Integer.parseInt(request.getParameter("RegistrationId")));
            request.setAttribute("registration", registration);
            RequestDispatcher rs = request.getRequestDispatcher("view/viewListDetail.jsp");
            rs.forward(request, response);
        }
        

        String requestType = request.getParameter("requestType");
        //parameter to go back
        HouseholdMemberDAO hmdb = new HouseholdMemberDAO();
        String backTo = request.getParameter("backTo");
        if (backTo != null && backTo.equals("approveRequest")) {
            RequestDispatcher rs = request.getRequestDispatcher("view/approveRequest.jsp");
            rs.forward(request, response);
        } else if ((backTo != null && backTo.equals("listApprove")) || requestType != null) {
            //calculate pagination
            List<Registration> requestList = rdb.getRequestTypeList(requestType);
            int page, numPerPage = 7;
            int size = requestList.size();
            int num = (size % numPerPage == 0 ? (size / numPerPage) : ((size / numPerPage) + 1));
            String xpage = request.getParameter("page");
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numPerPage;
            end = Math.min(page * numPerPage, size);
            List<Registration> requestListByPage = rdb.getRequestListByPage(requestList, start, end);

            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("requestList", requestListByPage);
            RequestDispatcher rs = request.getRequestDispatcher("view/viewListToBeApprove.jsp");
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
        //processRequest(request, response);       

        response.setContentType("text/html;charset=UTF-8");
        RegistrationDAO rdb = new RegistrationDAO();

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
