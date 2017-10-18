/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Medico;
import com.google.gson.Gson;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "ConsultaServlet", urlPatterns = {"/ConsultaServlet"})
public class ConsultaServlet extends HttpServlet {

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

            if ("ListaTiposConsulta".equals(action)) {
                try {
                    String json = new Gson().toJson(Facade.listarEspecialidades());
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if ("ListaClinicas".equals(action)) {
                try {
                    String json2 = new Gson().toJson(Facade.listarClinicas());
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json2);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if ("ListaCidades".equals(action)) {
                try {
                    String nome = request.getParameter("nome");
                    String json = new Gson().toJson(Facade.getCidadesPorNomeParcial(nome));
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(json);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            } else if ("BuscaConsultas".equals(action)) {
                try {
                    String tipo = request.getParameter("tipoConsulta");
                    String data = request.getParameter("data");
                    String clinica = request.getParameter("clinica");
                    String cidade = request.getParameter("cidade");
                    
                    Facade.BuscarIdMedicoPorLogin(1);//APAGAR ISSO PFVR
                    
                    
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/resultado-pesquisa-consulta.jsp");
                rd.forward(request, response);
            } else if ("BuscaConsultasMedico".equals(action)) {
                try {
                    int idMedico = Integer.parseInt(request.getParameter("idMedico"));
                    Medico medico = Facade.buscarMedicoPorId(idMedico);
                    //Facade.buscarConsultasMedico(medico); É PRECISO FAZER ESSE MÉTODO AINDA
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/calendario-clinica.jsp");
                rd.forward(request, response);
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
