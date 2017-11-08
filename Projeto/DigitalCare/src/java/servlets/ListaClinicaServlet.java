/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Consulta;
import beans.Estado;
import beans.Login;
import beans.Medico;
import facade.Facade;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "ListaClinicaServlet", urlPatterns = {"/ListaClinicaServlet"})
public class ListaClinicaServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        String status = "";
        Facade facade = new Facade();

        if ("listaConfiguracao".equals(action)) {
            String statusLista = "";
            try {
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica) session.getAttribute("usuario");
                statusLista = request.getParameter("status");
            } catch (Exception ex) {
                status = "error";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/configuracoes-clinica.jsp?status=" + statusLista);
            rd.forward(request, response);
        } else if ("PesquisaVinculaMedico".equals(action)) {
            try {
                String cpf = request.getParameter("cpf");
                cpf = cpf.replace("-", "");
                cpf = cpf.replace(".", "");

                Medico medico = Facade.getMedicoPorCPF(cpf);
                request.setAttribute("medico", medico);
                status = "listaMedico-ok";
                if (medico == null) {
                    status = "listaMedico-vazio";
                }
            } catch (Exception ex) {
                status = "ListaMedico-erro";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/vincular-medico.jsp?status=" + status);
            rd.forward(request, response);
        } else if ("dashboardClinica".equals(action)) {
            try {
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica) session.getAttribute("usuario");
                //busca consultas atuais
                List<Consulta> consultas = Facade.buscarConsultasAtuaisPorClinica(clinica);
                //busca próximas consultas
                List<Consulta> proximasConsultas = new ArrayList();
                List<Medico> medicosDaClinica = facade.carregaListaMedicosUnique(clinica.getId());
                for (Medico medico : medicosDaClinica) {
                    Consulta consulta = Facade.buscarProximaConsultaPorMedico(medico);
                    if (consulta != null) {
                        proximasConsultas.add(consulta);
                    }
                }
                //busca os status de todos os medicos da clinica
                List<String[]> statusConsultas = Facade.buscarStatusPorClinicaNoDia(clinica);
                request.setAttribute("consultasAtuais", consultas);
                request.setAttribute("proximasConsultas", proximasConsultas);
                request.setAttribute("statusConsultas", statusConsultas);
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/dashboard-clinica.jsp");
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
