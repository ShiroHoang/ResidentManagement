/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.RegistrationDAO;
import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Registration;
import model.User;

/**
 *
 * @author AN515-57
 */
public class PaginationServlet extends HttpServlet {

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
            out.println("<title>Servlet PaginationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaginationServlet at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);
        HttpSession session = request.getSession();
        UserDAO udb = new UserDAO();
        RegistrationDAO rdb = new RegistrationDAO();
        User user = (User) session.getAttribute("account");
        String xpage = request.getParameter("page");
        String action = request.getParameter("action");
        int page, numPerPage = 6;

        if (xpage == null) {
            page = 1;
        } else {
            page = Integer.parseInt(xpage);
        }

        if (action.equals("accountList")) {
            ArrayList<User> users = udb.getAll();
            ArrayList<User> list = udb.getUserByStartAndEnd(users, (page - 1) * numPerPage, page * numPerPage);
            request.setAttribute("list", list);
            int pagenum = (users.size() % numPerPage == 0) ? users.size() / numPerPage : users.size() / numPerPage + 1; //Get number of page
            request.setAttribute("pagenum", pagenum);
            request.getRequestDispatcher("view/accountList.jsp").forward(request, response);
            return;
        } else if (action.equals("requestList")) {
            //calculate pagination
            String requestType = request.getParameter("requestType");
            String residentName = request.getParameter("residentName");
            System.out.println(residentName);
            System.out.println(requestType);
            List<Registration> requestList;
            /// if does not have name of resident
            if(residentName == null){
                requestList = rdb.getRequestTypeList(requestType);
            }else{
                requestList = rdb.getRequestListByNameOfResidentAndRequestType(requestType, residentName );
            }
            int size = requestList.size();
            if(size == 0){
                requestList = null;
                request.setAttribute("requestList", requestList);
                request.getRequestDispatcher("view/viewListToBeApprove.jsp").forward(request, response);
                return;
            }
            int pagenum = (size % numPerPage == 0 ? (size / numPerPage) : ((size / numPerPage) + 1));
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numPerPage;
            end = Math.min(page * numPerPage, size);
            List<Registration> requestListByPage = rdb.getRequestListByPage(requestList, start, end);
            request.setAttribute("requestType", requestType);
            request.setAttribute("page", page);
            request.setAttribute("pagenum", pagenum);
            request.setAttribute("requestList", requestListByPage);
            RequestDispatcher rs = request.getRequestDispatcher("view/viewListToBeApprove.jsp");
            rs.forward(request, response);
        } else if (action.equals("viewRequest")) {
            List<Registration> list = rdb.filterRegistrationByUserID(user);
            int size = list.size();
            int pagenum = (size % numPerPage == 0 ? (size / numPerPage) : ((size / numPerPage) + 1));
            if (xpage == null) {
                page = 1;
            } else {
                page = Integer.parseInt(xpage);
            }
            int start, end;
            start = (page - 1) * numPerPage;
            end = Math.min(page * numPerPage, size);
            List<Registration> requestListByPage = rdb.getRequestListByPage(list, start, end);

            request.setAttribute("page", page);
            request.setAttribute("pagenum", pagenum);
            request.setAttribute("registrations", requestListByPage);
            
            request.setAttribute("rdb", rdb);
            RequestDispatcher rs = request.getRequestDispatcher("view/viewRequest.jsp");
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
