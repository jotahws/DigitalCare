/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;


import beans.Medicamento;
import com.google.gson.Gson;
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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
            
            //JASPER TEM QUE ADICIONAR TODAS AS BIBLIOTECAS
            try {
                String htmlao = "html do extrato";

                String jasper = request.getContextPath() + "/resources/reports/extrato_cfo.jasper";
                String host = "http://" + request.getServerName() + ":" + request.getServerPort();
                URL jasperURL = new URL(host + jasper);
                HashMap params = new HashMap();

                params.put("htmlao", htmlao);
                params.put("candidato_nome", "nome");
                params.put("candidato_curso", "curso");
//                File ufpr_logo = new File(context.getRealPath("/resources/images/ufpr.png"));
//                File pm_logo = new File(context.getRealPath("/resources/images/pmpr.png"));
//                InputStream fi = new FileInputStream(ufpr_logo);
//                params.put("UFPR_LOGO", fi);
//                fi = new FileInputStream(pm_logo);
//                params.put("PM_LOGO", fi);

                byte[] bytes = null;//JasperRunManager.runReportToPdf(jasperURL.openStream(), params, con);
                if (bytes != null) {
                    response.setContentType("application/pdf");
                    OutputStream ops = response.getOutputStream();
                    ops.write(bytes);
                }
            } catch (MalformedURLException ex) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write(ex.getMessage());
            }
            
            
            //TRATANDO AJAX
//            try {
//                String nome = request.getParameter("nome");
//                Medicamento medicamento = new Medicamento(nome);
//                List<Medicamento> medicamentos = Facade.getMedicamento(medicamento);
//                String json = new Gson().toJson(medicamentos);
//                response.setContentType("application/json");
//                response.setCharacterEncoding("UTF-8");
//                response.getWriter().write(json);
//            } catch (ClassNotFoundException | SQLException ex) {
//                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
//                response.getWriter().write(ex.getMessage());
//            }
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
