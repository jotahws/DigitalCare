/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Convenio;
import beans.Especialidade;
import beans.Estado;
import beans.Medico;
import com.google.gson.Gson;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String status = "";
        Facade facade = new Facade();

        if ("listaRegisterMedico".equals(action)) {
            String statusLista = "";
            try {
                try {
                    List<Estado> estados = facade.listarEstados();
                    HttpSession session = request.getSession();
                    Clinica clinica = (Clinica) session.getAttribute("usuario");
                    request.setAttribute("enderecos", clinica.getListaEnderecos());
                    request.setAttribute("estados", estados);
                    statusLista = request.getParameter("status");
                } catch (Exception ex) {
                    status = "error";
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/novo-medico.jsp?status=" + statusLista);
                rd.forward(request, response);
            } catch (NullPointerException | ClassCastException ex) {
                response.sendRedirect("login.jsp");
            }
        } else if ("listaConfigMedico".equals(action)) {
            String statusLista = "";
            try {
                try {
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    List<Especialidade> especMedico = facade.buscarEspecialidadesMedico(medico.getId());
                    List<Especialidade> espec = Facade.listarEspecialidades();
                    List<ClinicaEndereco> clinicas = Facade.getClinicaEnderecoPorMedico(medico);
                    List<Convenio> convenios = Facade.getListaConvenios();
                    List<Convenio> conveniosMedico = Facade.getListaConveniosMedico(medico.getId());
                    request.setAttribute("espec", espec);
                    request.setAttribute("clinicas", clinicas);
                    request.setAttribute("especMedico", especMedico);
                    request.setAttribute("convenios", convenios);
                    request.setAttribute("conveniosMedico", conveniosMedico);
                    statusLista = request.getParameter("status");
                } catch (Exception ex) {
                    status = "error";
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/configuracoes-medico.jsp?status=" + statusLista);
                rd.forward(request, response);
            } catch (NullPointerException | ClassCastException ex) {
                response.sendRedirect("login.jsp");
            }
        } else if ("listaMedicos".equals(action)) {
            try {
                try {
                    HttpSession session = request.getSession();
                    Clinica clinica = (Clinica) session.getAttribute("usuario");
                    List<Medico> medicos = facade.carregaListaMedicos(clinica.getId());
                    List<ClinicaEndereco> listaEndClinica = Facade.getListaEnderecosClinica(clinica.getId());
                    request.setAttribute("listaEndClinica", listaEndClinica);
                    request.setAttribute("listaMedicos", medicos);
                } catch (ClassNotFoundException ex) {
                    try (PrintWriter out = response.getWriter()) {
                        out.println("Class not found: " + ex.getMessage());
                    }
                } catch (SQLException ex) {
                    try (PrintWriter out = response.getWriter()) {
                        out.println("SQL not found: " + ex.getMessage());
                    }
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/medicos.jsp");
                rd.forward(request, response);
            } catch (NullPointerException | ClassCastException ex) {
                response.sendRedirect("login.jsp");
            }
        } else if ("verPerfilMedico".equals(action)) {
            int idLogin;
            try {
                idLogin = Integer.parseInt(request.getParameter("id"));
                int idClinicaEnd = Integer.parseInt(request.getParameter("clinicaEndereco"));
                ClinicaEndereco clinicaEnd = Facade.getClinicaEnderecoPorId(idClinicaEnd);
                Medico medico = Facade.getMedicoPorLogin(idLogin);
                medico.setLogin(Facade.buscaLoginPorId(idLogin));
                List<Especialidade> especMedico = Facade.buscarEspecialidadesMedico(medico.getId());
                List<Convenio> conveniosMedico = Facade.getListaConveniosMedico(medico.getId());
                medico.setListaConvenios(conveniosMedico);
                medico.setListaEspecialidades(especMedico);
                request.setAttribute("clinicaEndereco", clinicaEnd);
                request.setAttribute("medico", medico);
            } catch (Exception ex) {
                status = "error-perfil";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/perfil-medico.jsp");
            rd.forward(request, response);
        } else if ("horariosMedico".equals(action)) {
            try {
                int idMedico = Integer.parseInt(request.getParameter("idMedico"));
                Medico medico = Facade.buscarMedicoPorId(idMedico);
                medico.setListaHorarios(Facade.ListaHorariosPorMedico(medico));
                request.setAttribute("medico", medico);
                status = "horarios-ok";
            } catch (ClassNotFoundException | SQLException ex) {
                status = "horarios-error";
            }
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/horarios-medico.jsp");
            rd.forward(request, response);
        } else if ("PesquisaAJAX".equals(action)) {
            try {
                HttpSession session = request.getSession();
                Clinica clinica = (Clinica)session.getAttribute("usuario");
                String nome = request.getParameter("nome");
                List<Medico> medicos = Facade.getMedicosPorNome(nome);
                List<Medico> medicosDaClinica = new ArrayList();
                for (Medico medico : medicos) {
                    for(ClinicaEndereco clinicaEnd : medico.getListaClinicaEndereco()){
                        if (clinicaEnd.getClinica().getId() == clinica.getId()) {
                            medicosDaClinica.add(medico);
                        }
                        break;
                    }
                }
                String json = new Gson().toJson(medicosDaClinica);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json);
            } catch (ClassNotFoundException | NumberFormatException | SQLException | NullPointerException | ClassCastException ex) {
                Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
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
