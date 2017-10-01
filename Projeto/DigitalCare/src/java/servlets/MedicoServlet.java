/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Estado;
import beans.Login;
import beans.Medico;
import facade.Facade;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Gabriel
 */
@WebServlet(name = "MedicoServlet", urlPatterns = {"/MedicoServlet"})
public class MedicoServlet extends HttpServlet {

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

        String action = request.getParameter("action");
        String status;  
        
        if ("register".equals(action)){
            try {
                String nome = request.getParameter("nome");
                String sobrenome = request.getParameter("sobrenome");
                String email = request.getParameter("email");
                String cpf = request.getParameter("cpf");
                String numeroCrm = request.getParameter("numeroCrm");
                String dataNascimento = request.getParameter("dtnsc");
                String estadoCrm = request.getParameter("expedicao");
                String senha = request.getParameter("senha1");
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                Date dataNasc = formatter.parse(dataNascimento);
                cpf = cpf.replace("-", "");
                cpf = cpf.replace(".", "");
                Login login = new Login(email, senha, 2);
                Estado estado = Facade.buscarEstadoPorId(Integer.parseInt(estadoCrm));
                Medico medico = new Medico(login, estado, numeroCrm, nome, sobrenome, cpf, dataNasc);
                Facade.inserirMedico(medico);
                
                status = "cadastro-ok";
            } catch (ClassNotFoundException | SQLException | ParseException ex) {
                status = "cadastro-erro";
            }
            response.sendRedirect("novo-medico.jsp?status=" + status);
        } else if ("edit".equals(action)){
            try {
                String nome = request.getParameter("nome");
                String sobrenome = request.getParameter("sobrenome");
                String dataNascimento = request.getParameter("dtnsc");
                String precoConsulta = request.getParameter("precoConsulta");
                String telefone1 = request.getParameter("telefone1");
                String telefone2 = request.getParameter("telefone2");
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
                Date dataNasc = formatter.parse(dataNascimento);
                telefone1 = telefone1.replace("(", "");
                telefone1 = telefone1.replace(")", "");
                telefone1 = telefone1.replace(" ", "");
                telefone1 = telefone1.replace("-", "");
                telefone2 = telefone2.replace("(", "");
                telefone2 = telefone2.replace(")", "");
                telefone2 = telefone2.replace(" ", "");
                telefone2 = telefone2.replace("-", "");
                HttpSession session = request.getSession();
                Login login = (Login)session.getAttribute("sessionLogin");
                int idMedico = Facade.BuscarIdMedicoPorLogin(login.getId());
                Medico medico = new Medico(idMedico, nome, sobrenome, Double.parseDouble(precoConsulta), dataNasc, telefone1, telefone2);
                Facade.atualizarMedico(medico);
                
//                status = "cadastro-ok";
            } catch (ClassNotFoundException | SQLException | ParseException ex) {
//                status = "cadastro-erro";
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
