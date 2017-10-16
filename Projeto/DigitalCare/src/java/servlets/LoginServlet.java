/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Clinica;
import beans.Login;
import beans.Medico;
import beans.PacienteUsuario;
import facade.Facade;
import java.io.IOException;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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

        Facade facade = new Facade();
        String action = request.getParameter("action");

        if ("login".equals(action)) {

            String email = request.getParameter("login");
            String senha = request.getParameter("senha");

            try {
                Login login = new Login();
                senha = login.criptografa(senha);
                login.setEmail(email);
                login.setSenha(senha);
//                senha = login.criptografa(senha);;
                login = facade.verificaLogin(login);

                HttpSession session = request.getSession();
                session.setAttribute("sessionLogin", login);

                switch (login.getPerfil()) {
                    case 1:
                        PacienteUsuario pacienteUsuario = Facade.buscarPacienteUsuarioPorIdLogin(login.getId());
                        pacienteUsuario.setLogin(login);
                        session.setAttribute("usuario", pacienteUsuario);
                        response.sendRedirect("paciente-home.jsp");
                        break;
                    case 2:
                        Medico medico = Facade.getMedicoPorLogin(login.getId());
                        medico.setListaEspecialidades(Facade.getListaEspecialidadesMedico(medico.getId()));
                        medico.setListaConvenios(Facade.getListaConveniosMedico(medico.getId()));
                        medico.setLogin(login);
                        session.setAttribute("usuario", medico);
                        response.sendRedirect("dashboard.jsp");
                        break;
                    case 3:
                        Clinica clinica = Facade.getClinicaPorLogin(login.getId());
                        clinica.setListaEnderecos(Facade.getListaEnderecosClinica(clinica.getId()));
                        clinica.setLogin(login);
                        session.setAttribute("usuario", clinica);
                        response.sendRedirect("dashboard-clinica.jsp");
                        break;
                }

            } catch (Exception ex) {
                response.sendRedirect("login.jsp?status=login-erro");
            }
        } else if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp");
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
