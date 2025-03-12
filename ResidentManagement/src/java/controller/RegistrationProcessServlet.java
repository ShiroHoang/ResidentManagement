/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressRegistryDAO;
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
import java.util.ArrayList;
import java.util.List;
import model.AddressRegistry;
import model.HouseholdMember;
import model.Log;
import model.Registration;
import model.User;

/**
 *
 * @author huyng
 */
public class RegistrationProcessServlet extends HttpServlet {

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
            out.println("<title>Servlet RegistrationProcessServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationProcessServlet at " + request.getContextPath() + "</h1>");
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
        User user = (User) session.getAttribute("account");
        if (user == null) {
            response.sendRedirect("login");
        } else {
            RegistrationDAO rdb = new RegistrationDAO();
            List<Registration> list = rdb.filterRegistrationByUserID(user);
            request.setAttribute("registrations", list);
            request.getRequestDispatcher("view/viewRequest.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        HouseholdMemberDAO hhmd = new HouseholdMemberDAO();
        HouseholdDAO hhd = new HouseholdDAO();
        LogDAO logdb = new LogDAO();
        RegistrationDAO rdb = new RegistrationDAO();
        AddressRegistryDAO ardb = new AddressRegistryDAO();
        HouseholdMemberDAO hmdb = new HouseholdMemberDAO();
        HouseholdDAO hdb = new HouseholdDAO();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String formattedDate = today.format(formatter);
        if (user == null) {
            response.sendRedirect("login");
        } else {
            if (action.equalsIgnoreCase("registerAddress")) {
                String province = request.getParameter("province");
                String city = request.getParameter("city");
                String district = request.getParameter("district");
                String ward = request.getParameter("ward");
                String street = request.getParameter("street");
                String house = request.getParameter("house");
                String typeStay = request.getParameter("stay");
                String headOfHousehold = request.getParameter("headOfHousehold");
                String relationship = request.getParameter("relationship");
                AddressRegistry registerAddress = new AddressRegistry(province, city, district, ward, street, house);
                int addressID = ardb.getAddressId(registerAddress);
                int headOfHouseholdID = hmdb.existHeadOfHouseholdId(headOfHousehold);
                int householdID = hdb.getHouseholdIDByAddressIdAndHeadOfHouseholdId(addressID, headOfHouseholdID );
                if (hmdb.existTypeStayPermanentOfMember(user) && typeStay.equalsIgnoreCase("permanent")) {
                    request.setAttribute("message", "Bạn đã có thường trú, không thể đăng ký thường trú mới");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else if (!headOfHousehold.isEmpty() && headOfHouseholdID == -1) { //trường hợp nhập sai tên chủ hộ khẩu
                    request.setAttribute("message", "Bạn đã nhập sai tên chủ hộ khẩu");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else if (!headOfHousehold.isEmpty() && headOfHouseholdID != -1) { //trường hợp có chủ hộ khẩu và điền đúng tên chủ hộ khẩu
                    rdb.newRegistrationRegisterAddressWithHeadOfHousehold(user, typeStay, formattedDate, addressID, action, headOfHouseholdID, relationship);
                    Log log = new Log(user.getUserId(), "Đăng ký hộ khẩu mới", formattedDate);
                    logdb.insertNewLog(log);
                    request.setAttribute("message", "Đơn của bạn đã được nộp thành công");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else if (headOfHousehold.isEmpty() && householdID != -1) { //trong trường hợp địa chỉ đã có chủ hộ khẩu và cần nhập tên chủ hộ khẩu
                    request.setAttribute("message", "Địa chỉ đã có chủ hộ khẩu đăng ký, cần nhập tên chủ hộ khẩu !");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else if (headOfHousehold.isEmpty() && householdID == -1) { //trong trường hợp địa chỉ chưa có chủ hộ khẩu và không cần nhập tên
                    rdb.newRegistrationRegisterAddress(user, typeStay, formattedDate, addressID, action);
                    Log log = new Log(user.getUserId(), "Đăng ký hộ khẩu mới", formattedDate);
                    logdb.insertNewLog(log);
                    request.setAttribute("message", "Đơn của bạn đã được nộp thành công");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                }
            } else if (action.equalsIgnoreCase("moveAddress")) {
                //incase citizen do not have permanent residence

                String headOfHouseholdFullName = request.getParameter("headOfHousehold");
                String relationship = request.getParameter("relationship");
                //incase citizen do not have permanent residence
                if (!hmdb.existTypeStayPermanentOfMember(user)) {
                    request.setAttribute("message", "Bạn chưa có hộ khẩu thường trú");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                    return;
                }
                String provinceOld = request.getParameter("provinceOld");
                String cityOld = request.getParameter("cityOld");
                String districtOld = request.getParameter("districtOld");
                String wardOld = request.getParameter("wardOld");
                String streetOld = request.getParameter("streetOld");
                String houseOld = request.getParameter("houseOld");
                String typeStay = "permanent"; //because of gov policy
                AddressRegistry registerAddressOld = new AddressRegistry(provinceOld, cityOld, districtOld, wardOld, streetOld, houseOld);
                int oldAddressID = ardb.getAddressId(registerAddressOld);

                String provinceMoved = request.getParameter("provinceMoved");
                String cityMoved = request.getParameter("cityMoved");
                String districtMoved = request.getParameter("districtMoved");
                String wardMoved = request.getParameter("wardMoved");
                String streetMoved = request.getParameter("streetMoved");
                String houseMoved = request.getParameter("houseMoved");
                AddressRegistry registerAddressMoved = new AddressRegistry(provinceMoved, cityMoved, districtMoved, wardMoved, streetMoved, houseMoved);
                int movedAddressID = ardb.getAddressId(registerAddressMoved);

                if (oldAddressID == -1 || movedAddressID == -1) {
                    request.setAttribute("message", "Vui lòng nhập đầy đủ thông tin địa chỉ");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                    return;
                }

                ArrayList<Integer> headOfHouseholdByAddressIds = hdb.getHeadOfHouseholdIdByAddressId(movedAddressID);
                if (headOfHouseholdByAddressIds.contains(hmdb.existHeadOfHouseholdId(headOfHouseholdFullName))
                            && headOfHouseholdFullName.isEmpty()) {
                    request.setAttribute("message", "Địa chỉ đăng ký đã có chủ hộ khẩu! Vui lòng nhập tên chủ hộ");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else if (headOfHouseholdByAddressIds.contains(hmdb.existHeadOfHouseholdId(headOfHouseholdFullName))
                            && relationship.isEmpty()) {
                    request.setAttribute("message", "Địa chỉ đăng ký có chủ hộ khẩu! Vui lòng nhập quan hệ với chủ hộ");
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else {
                    Log log = new Log(user.getUserId(), "Chuyển hộ khẩu", formattedDate);
                    logdb.insertNewLog(log);
                    rdb.newRegistrationMovedAddress(user, typeStay, formattedDate, oldAddressID, movedAddressID, action, hmdb.existHeadOfHouseholdId(headOfHouseholdFullName), relationship);
                    String message = "Đơn của bạn đã được nộp thành công";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                }

            } else if (action.equalsIgnoreCase("separateAddress")) {
                int householdId = hhmd.findPermanentHouseHoldId(user);
                String typeStay = "permanent";
                if (householdId == -1) {
                    String message = "Bạn chưa có hộ khẩu đăng kí thường trú để thực hiện tách hộ khẩu!";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                } else {
                    int headOfHouseHoldId = hhd.getHeadOfHouseHoldByHouseHoldId(householdId);
                    int currentAddressID = hhd.getAddressIdByHouseHoldId(householdId);
                    Log log = new Log(user.getUserId(), "Đơn tách hộ khẩu", formattedDate);
                    logdb.insertNewLog(log);
                    rdb.newRegistrationSeparateAddress(user, typeStay, formattedDate, currentAddressID, headOfHouseHoldId, action);
                    String message = "Đơn của bạn đã được nộp thành công";
                    request.setAttribute("message", message);
                    request.getRequestDispatcher("view/submitRequest.jsp").forward(request, response);
                }
            }
        }

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
