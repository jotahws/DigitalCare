/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.ClinicaEndereco;
import beans.Consulta;
import beans.Medico;
import beans.Paciente;
import beans.PacienteUsuario;
import com.google.gson.Gson;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
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
 * @author JotaWind
 */
@WebServlet(name = "EstadoConsultaServlet", urlPatterns = {"/EstadoConsultaServlet"})
public class EstadoConsultaServlet extends HttpServlet {

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

            if ("MarcaConsulta".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    PacienteUsuario pacienteUsuario = (PacienteUsuario) session.getAttribute("usuario");
                    int idClinicaEnd = Integer.parseInt(request.getParameter("idClinicaEnd"));
                    int idMedico = Integer.parseInt(request.getParameter("idMedico"));
                    String datahoraString = request.getParameter("datahora");
                    Date datahora = Timestamp.valueOf(datahoraString);
                    Medico medico = new Medico();
                    Paciente paciente = new Paciente();
                    ClinicaEndereco clinicaEndereco = new ClinicaEndereco();
                    medico.setId(idMedico);
                    paciente.setId(pacienteUsuario.getPaciente().getId());
                    clinicaEndereco.setId(idClinicaEnd);
                    Consulta consulta = new Consulta(datahora, "Marcado", medico, paciente, clinicaEndereco);
                    consulta = Facade.marcaConsulta(consulta);
                    status = "consulta-marcada";
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-nova-consulta";
                }
                response.sendRedirect("ConsultaServlet?action=homePaciente&status=" + status +"#pesquisar");

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
