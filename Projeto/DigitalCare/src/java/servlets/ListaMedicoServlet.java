/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Estado;
import beans.Login;
import beans.Medico;
import daos.MedicoDAO;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JotaWind
 */
@WebServlet(name = "ListaMedicoServlet", urlPatterns = {"/ListaMedicoServlet"})
public class ListaMedicoServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        String status = "";
        Facade facade = new Facade();

        if ("listaRegisterMedico".equals(action)) {
            String statusLista = "";
            try {
                List<Estado> estados = facade.listarEstados();
                request.setAttribute("estados", estados);
                statusLista = request.getParameter("status");
            } catch (Exception ex) {
                status = "error";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/novo-medico.jsp?status=" + statusLista);
            rd.forward(request, response);
        } else if ("listaConfigMedico".equals(action)) {
            String statusLista = "";
            try {
                HttpSession session = request.getSession();
                Login login = (Login) session.getAttribute("sessionLogin");
                Medico medico = Facade.getMedicoPorLogin(login.getId());
                List<Estado> estados = facade.listarEstados();
                request.setAttribute("estados", estados);
                request.setAttribute("medico", medico);
                statusLista = request.getParameter("status");
                
            } catch (Exception ex) {
                status = "error";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/configuracoes-medico.jsp?status=" + statusLista);
            rd.forward(request, response);
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
        processRequest(request, response);
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
