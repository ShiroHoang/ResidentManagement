/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AddressRegistryDAO;
import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObject;
import jakarta.json.JsonWriter;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.AddressRegistry;

/**
 *
 * @author huyng
 */
public class AddressServlet extends HttpServlet {

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
            out.println("<title>Servlet AddressServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddressServlet at " + request.getContextPath() + "</h1>");
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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JsonArrayBuilder jsonArrayBuilder = Json.createArrayBuilder();
        AddressRegistryDAO ardb = new AddressRegistryDAO();
        List<AddressRegistry> list = new ArrayList<>();
        list = ardb.getAll();
        for (AddressRegistry addressRegistry : list) {
            JsonObject jsonObject = (JsonObject) Json.createObjectBuilder()
                    .add("province", addressRegistry.getProvince())
                    .add("city", addressRegistry.getCity())
                    .add("district", addressRegistry.getDistrict())
                    .add("ward", addressRegistry.getWard())
                    .add("street", addressRegistry.getStreet())
                    .add("house", addressRegistry.getHouseNumber()).build();

            jsonArrayBuilder.add(jsonObject);
        }
        try (JsonWriter jsonWriter = Json.createWriter(out)) {
            jsonWriter.writeArray(jsonArrayBuilder.build());
        }
        out.flush();
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
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String street = request.getParameter("street");
        String house = request.getParameter("house");
        AddressRegistryDAO ardb = new AddressRegistryDAO();
        if (action.equalsIgnoreCase("registerAddress")) {
            AddressRegistry registerAddress = new AddressRegistry(province, city, district, ward, street, house);
            if (ardb.checkAddressRegistry(registerAddress)) {
                //incase already have
                
            } else { //dont have address
                ardb.insertNewAddressRegistry(registerAddress);
                String mess = "You have been added to an existing address";
                request.setAttribute("message", mess);
                request.getRequestDispatcher("submitRequest.jsp").forward(request, response);
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
