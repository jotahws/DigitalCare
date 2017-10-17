/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.ClinicaEndereco;
import beans.HorarioDisponivel;
import beans.Medico;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author JotaWind
 */
@WebServlet(name = "HorarioServlet", urlPatterns = {"/HorarioServlet"})
public class HorarioServlet extends HttpServlet {

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

        if ("adicionarHorario".equals(action)) {
            int idMedicoLogin = Integer.parseInt(request.getParameter("idMedico"));
            try {
                int diaSemana = Integer.parseInt(request.getParameter("dia-semana"));
                String inicioString = request.getParameter("inicio");
                String fimString = request.getParameter("fim");
                int idClinicaEnd = Integer.parseInt(request.getParameter("idClinicaEnd"));
                DateFormat formatter = new SimpleDateFormat("HH:mm");

                Medico medico = Facade.buscarMedicoPorId(idMedicoLogin);
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(idClinicaEnd);
                Time inicio = new Time(formatter.parse(inicioString).getTime());
                Time fim = new Time(formatter.parse(fimString).getTime());

                HorarioDisponivel horarioDisponivel = new HorarioDisponivel(diaSemana, inicio, fim, medico, clinicaEndereco);

                Facade.inserirHorarioDisponivel(horarioDisponivel);

                status = "adiciona-ok";
            } catch (Exception ex) {
                status = "adiciona-erro";
            }
            response.sendRedirect("ListaMedicoServlet?action=horariosMedico&idMedico=" + idMedicoLogin +"&status=" + status);
        }
        if ("deletarHorario".equals(action)) {
            int idMedicoLogin = Integer.parseInt(request.getParameter("idMedico"));
            try {
                int idHorario = Integer.parseInt(request.getParameter("idHorario"));

                HorarioDisponivel horarioDisponivel = new HorarioDisponivel();
                horarioDisponivel.setId(idHorario);

                Facade.deletarHorarioDisponivel(horarioDisponivel);

                status = "delete-ok";
            } catch (Exception ex) {
                status = "delete-erro";
            }
            response.sendRedirect("ListaMedicoServlet?action=horariosMedico&idMedico=" + idMedicoLogin +"&status=" + status);
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
