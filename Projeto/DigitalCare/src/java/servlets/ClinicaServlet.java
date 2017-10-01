/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Cidade;
import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Endereco;
import beans.Login;
import facade.Facade;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gabriel
 */
@WebServlet(name = "ClinicaServlet", urlPatterns = {"/ClinicaServlet"})
public class ClinicaServlet extends HttpServlet {

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
        Facade facade = new Facade();
        String status = "";  
        
        if ("register".equals(action)){
            try {
                String nomeFantasia = request.getParameter("nomeFantasia");
                String razaoSocial = request.getParameter("razaoSocial");
                String cnpj = request.getParameter("cnpj");
                String site = request.getParameter("site");
                String tel1 = request.getParameter("tel1");
                String tel2 = request.getParameter("tel2");
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String cep = request.getParameter("cep");
                String rua = request.getParameter("rua");
                String numero = request.getParameter("numero");
                String complemento = request.getParameter("compl");
                String bairro = request.getParameter("bairro");
                String cidadeString = request.getParameter("cidade");
                cnpj = cnpj.replace("-", "");
                cnpj = cnpj.replace(".", "");
                cnpj = cnpj.replace("/", "");
                tel1 = tel1.replace("(", "");
                tel1 = tel1.replace(")", "");
                tel1 = tel1.replace(" ", "");
                tel1 = tel1.replace("-", "");
                tel2 = tel2.replace("(", "");
                tel2 = tel2.replace(")", "");
                tel2 = tel2.replace(" ", "");
                tel2 = tel2.replace("-", "");
                cep = cep.replace("-", "");
                cep = cep.replace(".", "");
                
                Login login = new Login(email, senha, 3);
                Clinica clinica = new Clinica(login, cnpj, razaoSocial, nomeFantasia, site);
                Cidade cidade = facade.getCidadePorNome(cidadeString);
                Endereco endereco = new Endereco(cidade, cep, rua, numero, complemento, bairro);
                ClinicaEndereco clinicaEndereco = new ClinicaEndereco(clinica, endereco, tel1, tel2);
                facade.inserirClinicaEndereco(clinicaEndereco);

                status = "cadastro-ok";
            } catch (ClassNotFoundException | SQLException ex) {
                status = "cadastro-erro";
            }
            response.sendRedirect("login.jsp?status=" + status);
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
