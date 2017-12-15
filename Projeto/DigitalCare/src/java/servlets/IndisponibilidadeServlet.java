/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Falta;
import beans.Medico;
import com.google.gson.Gson;
import facade.Facade;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author joao.wind
 */
@WebServlet(name = "IndisponibilidadeServlet", urlPatterns = {"/IndisponibilidadeServlet"})
public class IndisponibilidadeServlet extends HttpServlet {

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
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession verSession = request.getSession();
        if (verSession != null) {

            String action = request.getParameter("action");
            Facade facade = new Facade();
            String status = "";

            if ("InserirFalta".equals(action)) {
                try {
                    String dataInicio = request.getParameter("dataInicio") + " " + request.getParameter("de");
                    String dataFim = request.getParameter("dataInicio") + " " + request.getParameter("ate");
                    SimpleDateFormat datefmt = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                    Calendar calInicio = Calendar.getInstance();
                    calInicio.setTime(datefmt.parse(dataInicio));
                    Calendar calFim = Calendar.getInstance();
                    calFim.setTime(datefmt.parse(dataFim));
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    Falta falta = new Falta(medico, calInicio, calFim);
                    falta = Facade.setFalta(falta);
                    status = "falta-ok";
                } catch (ClassNotFoundException | SQLException | ParseException ex) {
                    status = "falta-erro";
                }
                response.sendRedirect("ConsultaServlet?action=indisponibilidade&status="+status);
            }else if ("deleteFalta".equals(action)) {
                Falta falta = new Falta();
                falta.setId(Integer.parseInt(request.getParameter("idFalta")));
                try {
                    Facade.apagarFaltas(falta);
                    status="apagaFalta-ok";
                } catch (ClassNotFoundException | SQLException ex) {
                    status="apagaFalta-erro";
                }
                response.sendRedirect("ConsultaServlet?action=BuscaConsultasMedico&status="+status);
            }
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
