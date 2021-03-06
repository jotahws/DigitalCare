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
                    Facade.marcaConsulta(consulta);
                    status = "consulta-marcada";
                } catch (ClassNotFoundException | NumberFormatException | SQLException | NullPointerException | ClassCastException ex) {
                    status = "erro-nova-consulta";
                }
                response.sendRedirect("ConsultaServlet?action=homePaciente&status=" + status + "#pesquisar");

            } else if ("CancelaConsulta".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    Facade.cancelaConsulta(consulta);
                    status = "consulta-cancelada";
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-cancela-consulta";
                }
                response.sendRedirect("ConsultaServlet?action=homePaciente&status=" + status + "#pesquisar");
            } else if ("CancelaConsultaMedico".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    Facade.cancelaConsulta(consulta);
                    status = "consulta-cancelada";
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-cancela-consulta";
                }
                response.sendRedirect("ConsultaServlet?action=Dashboard&status=" + status);
            } else if ("CancelaConsultaClinica".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    Facade.cancelaConsulta(consulta);
                    status = "consulta-cancelada";
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-cancela-consulta";
                }
                response.sendRedirect("calendario-clinica.jsp?status=" + status);
            } else if ("iniciaConsulta".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    //CONCLUIR OUTRA CONSULTA SE ESTIVER EM ANDAMENTO
                    Consulta consultaAtual = Facade.getConsultaAtual(medico);
                    if (consultaAtual != null) {
                        Facade.concluiConsulta(consultaAtual);
                    }
                    consulta = Facade.iniciaConsulta(consulta);
                    //COLOCAR A CONSULTA INICIADA NA SESSAO
                    session.setAttribute("consultaAtual", consulta);
                    status = "consulta-iniciada";
                } catch (ClassNotFoundException | NumberFormatException | SQLException | NullPointerException | ClassCastException ex) {
                    status = "erro-inicia-consulta";
                }
                response.sendRedirect("consulta-atual.jsp?status=" + status);
            } else if ("concluiConsulta".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    Facade.concluiConsulta(consulta);
                    HttpSession session = request.getSession();
                    //TIRAR A CONSULTA INICIADA DA SESSAO
                    Consulta consultaAtual = (Consulta) session.getAttribute("consultaAtual");
                    if (consultaAtual != null) {
                        if (consulta.getId() == consultaAtual.getId()) {
                            session.setAttribute("consultaAtual", null);
                        }
                    }
                    status = "consulta-concluida";
                } catch (ClassNotFoundException | NumberFormatException | SQLException | NullPointerException | ClassCastException ex) {
                    status = "erro-conclui-consulta";
                }
                response.sendRedirect("ConsultaServlet?action=BuscaConsultasMedico&status=" + status);
            } else if ("concluiConsultaClinica".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    Facade.concluiConsulta(consulta);
                    HttpSession session = request.getSession();
                    //TIRAR A CONSULTA INICADA DA SESSAO
                    session.setAttribute("consultaAtual", null);
                    status = "consulta-concluida";
                } catch (ClassNotFoundException | NumberFormatException | SQLException | NullPointerException | ClassCastException ex) {
                    status = "erro-conclui-consulta";
                }
                response.sendRedirect("calendario-clinica.jsp?status=" + status);
            } else if ("pacienteEmEspera".equals(action)) {
                try {
                    int idConsulta = Integer.parseInt(request.getParameter("idConsulta"));
                    Consulta consulta = new Consulta();
                    consulta.setId(idConsulta);
                    Facade.pacienteEmEspera(consulta);
                    status = "consulta-em-espera";
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-consulta-em-espera";
                }
                response.sendRedirect("calendario-clinica.jsp?status=" + status);
            } else if ("proximaConsulta".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    Consulta consultaNova = Facade.proximoPaciente(medico);
                    session.setAttribute("consultaAtual", consultaNova);
                    status = "proxima-consulta-ok";
                } catch (ClassNotFoundException | NumberFormatException | SQLException | ClassCastException ex) {
                    status = "erro-proxima-consulta";
                } catch (NullPointerException ex) {
                    status = "sem-proxima-consulta";
                }
                response.sendRedirect("consulta-atual.jsp?status="+status);
            } else if ("ClinicaMarcaConsulta".equals(action)) {
                try {
                    PacienteUsuario pacienteUsuario = Facade.getPacienteUsuarioPorIdPaciente(Integer.parseInt(request.getParameter("idPaciente")));
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
                    Facade.marcaConsulta(consulta);
                    status = "consulta-marcada";
                } catch (ClassNotFoundException | SQLException ex) {
                    status = "erro-nova-consulta";
                }
                response.sendRedirect("agendar-consulta.jsp?status=" + status);

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
