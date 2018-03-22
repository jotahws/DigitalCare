/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;


import beans.Medicamento;
import com.google.gson.Gson;
import conexao.ConnectionFactory;
import facade.Facade;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author joao.wind
 */
@WebServlet(name = "ProntuarioServlet", urlPatterns = {"/ProntuarioServlet"})
public class ProntuarioServlet extends HttpServlet {

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

        if ("atestado".equals(action)) {
            //1. Emitir PDF
            //2. Salvar PDF no BD
            //3. Retornar STATUS na jsp
            
            try {
                Connection con = new ConnectionFactory().getConnection();

                String jasper = request.getContextPath() + "/jasper/atestado.jasper";
                String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                URL jasperURL = new URL(host + jasper);
                HashMap params = new HashMap();

                params.put("ATESTADO", request.getParameter("texto"));
                params.put("CLINICA_NOME", request.getParameter("nomeClinica"));
                params.put("PACIENTE_NOME", request.getParameter("nome"));
                params.put("PACIENTE_END", request.getParameter("endereco"));
                params.put("CLINICA_NOME_ENDERECO", request.getParameter("nomeClinicaEndereco"));
                params.put("CLINICA_ENDERECO", request.getParameter("clinicaEndereco"));
                params.put("CLINICA_TELEFONE", request.getParameter("clinicaTelefone"));
                params.put("CLINICA_CNPJ", request.getParameter("clinicaCNPJ"));
                ServletContext context = getServletContext();
                File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                InputStream fi = new FileInputStream(digital_logo);
                params.put("DIGITAL_LOGO", fi);

                byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                if (bytes != null) {
                    response.setContentType("application/pdf");
                    OutputStream ops = response.getOutputStream();
                    ops.write(bytes);
                }
            } catch (Exception ex) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(ex.getMessage());
            }
        } else if("atestadoPDF".equals(action)){
            //1. Emitir PDF
            //2. Retornar PDF na jsp
            
            try {
                Connection con = new ConnectionFactory().getConnection();

                String jasper = request.getContextPath() + "/jasper/atestado.jasper";
                String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                URL jasperURL = new URL(host + jasper);
                HashMap params = new HashMap();

                params.put("ATESTADO", request.getParameter("texto"));
                params.put("CLINICA_NOME", request.getParameter("nomeClinica"));
                params.put("PACIENTE_NOME", request.getParameter("nome"));
                params.put("PACIENTE_END", request.getParameter("endereco"));
                params.put("CLINICA_NOME_ENDERECO", request.getParameter("nomeClinicaEndereco"));
                params.put("CLINICA_ENDERECO", request.getParameter("clinicaEndereco"));
                params.put("CLINICA_TELEFONE", request.getParameter("clinicaTelefone"));
                params.put("CLINICA_CNPJ", request.getParameter("clinicaCNPJ"));
                ServletContext context = getServletContext();
                File digital_logo = new File(context.getRealPath("/images/logo-peq.png"));
                InputStream fi = new FileInputStream(digital_logo);
                params.put("DIGITAL_LOGO", fi);

                byte[] bytes = JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                if (bytes != null) {
                    response.setContentType("application/pdf");
                    OutputStream ops = response.getOutputStream();
                    ops.write(bytes);
                }
            } catch (Exception ex) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(ex.getMessage());
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
