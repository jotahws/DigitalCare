/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Cidade;
import beans.Endereco;
import beans.Estado;
import beans.Paciente;
import beans.PacienteUsuario;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(name = "PacienteServlet", urlPatterns = {"/PacienteServlet"})
public class PacienteServlet extends HttpServlet {

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

        if ("register".equals(action)) {
            try {
                String nome = request.getParameter("nome");
                String sobrenome = request.getParameter("sobrenome");
                String cpf = request.getParameter("cpf");
                String dtnsc = request.getParameter("dtnsc");
                String sexo = request.getParameter("sexo");
                String tel1 = request.getParameter("tel1");
                String tel2 = request.getParameter("tel2");
                String email = request.getParameter("email");
                String pssw = request.getParameter("pssw");
                String pssw2 = request.getParameter("pssw2");
                String cep = request.getParameter("cep");
                String rua = request.getParameter("rua");
                String numero = request.getParameter("numero");
                String compl = request.getParameter("compl");
                String bairro = request.getParameter("bairro");
                String estadoString = request.getParameter("estado");
                String cidadeString = request.getParameter("cidade");
//                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");;
//                Date dataNasc = formatter.parse(dtnsc);
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                Date dataNasc = sdf.parse("27/07/2006");

                Paciente paciente = new Paciente(cpf, nome, sobrenome, dataNasc, sexo);
                Cidade cidade = facade.getCidadePorId(1);
                Endereco endereco = new Endereco(cidade, cep, rua, numero, compl, bairro);
                PacienteUsuario pacienteUsuario = new PacienteUsuario(paciente, endereco, email, pssw, tel1, tel2);
                facade.inserirPacienteUsuario(pacienteUsuario);

                status = "successCadastro";
            } catch (Exception ex) {
                status = "error";
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
