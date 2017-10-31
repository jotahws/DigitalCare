/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Consulta;
import beans.Especialidade;
import beans.MedicoHorario;
import beans.Medico;
import beans.MedicoFalta;
import beans.PacienteUsuario;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dtos.DiaDisponivelDTO;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
                    Especialidade especialidade = Facade.buscarEspecialidadePorId(Integer.parseInt(tipo));
                    String data = request.getParameter("data");
                    String clinica = request.getParameter("clinica");
                    String cidade = request.getParameter("cidade");
                    SimpleDateFormat sdfEntrada = new SimpleDateFormat("dd-MM-yyyy");
                    Date date = new Date();
                    if (!"".equals(data)) {
                        data = data.replace("/", "-");
                        date = sdfEntrada.parse(data);
                    }
                    GregorianCalendar cal = new GregorianCalendar();
                    cal.setTime(date);
                    cal.add(GregorianCalendar.DAY_OF_MONTH, -3);
                    int iDomingo = cal.get(GregorianCalendar.SUNDAY);
                    Date dtInicio = cal.getTime();
                    cal.add(GregorianCalendar.DAY_OF_MONTH, 6);
                    Date dtFim = cal.getTime();
                    List<DiaDisponivelDTO> listaDiasSemana = Facade.instanciaListaDias(7, dtInicio);
                    List<Medico> medicoLista = Facade.getMedicosPorNome("");
                    List<MedicoHorario> listaMedicoHorario = new ArrayList();
                    List<Medico> listaMedicos = new ArrayList();
                    for (Medico medicoAux : medicoLista) {
                        listaMedicoHorario = Facade.buscarHorariosConsulta(tipo, cidade, clinica, medicoAux);
                        if (listaMedicoHorario.size() > 0) {
                            medicoAux.setListaHorarios(listaMedicoHorario);
                            listaMedicos.add(medicoAux);
                        }
                    }
                    if (listaMedicos.size() > 0) {
                        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
                        String str = "08:00";
                        String str2 = "20:00";
                        Date hrInicial = format.parse(str);
                        Date hrFinal = format.parse(str2);
                        for (Medico medicoAux : listaMedicos) {
                            medicoAux.setListaConsultas(Facade.buscarConsultasSemana(dtInicio, dtFim, medicoAux.getId()));
                            medicoAux.setListaFaltas(Facade.buscarFaltasSemana(dtInicio, dtFim, medicoAux.getId()));
                            for (MedicoHorario medHor : medicoAux.getListaHorarios()) {
                                int index = (medHor.getDiaSemana() + iDomingo - 1) % 7;
                                Facade.adicionarHorariosMedico(listaDiasSemana.get(index), medHor);
                            }
                            for (MedicoFalta medFal : medicoAux.getListaFaltas()) {
                                Date dataI;
                                if (dtInicio.after(medFal.getDataInicio())) {
                                    dataI = dtInicio;
                                } else {
                                    dataI = medFal.getDataInicio();
                                }
                                cal.setTime(dataI);
                                int indexDataInicio = (cal.get(GregorianCalendar.DAY_OF_WEEK) + iDomingo - 1) % 7;
                                if (medFal.getDataFim() == null) {
                                    if (medFal.getHoraInicio() == null) {
                                        Facade.removerHorariosMedico(listaDiasSemana.get(indexDataInicio), hrInicial,
                                                hrFinal, medicoAux);
                                    } else {
                                        Facade.removerHorariosMedico(listaDiasSemana.get(indexDataInicio), medFal.getHoraInicio(),
                                                medFal.getHoraFim(), medicoAux);
                                    }
                                } else {
                                    Date dataF;
                                    if (dtFim.after(medFal.getDataInicio())) {
                                        dataF = medFal.getDataFim();
                                    } else {
                                        dataF = dtFim;
                                    }
                                    cal.setTime(dataF);
                                    int indexDataFinal = (cal.get(GregorianCalendar.DAY_OF_WEEK) + iDomingo - 1) % 7;
                                    Facade.removerHorariosMedico(listaDiasSemana.get(indexDataInicio), medFal.getHoraInicio(),
                                            hrFinal, medicoAux);
                                    for (Integer i = indexDataInicio + 1; i < indexDataFinal; i++) {
                                        Facade.removerHorariosMedico(listaDiasSemana.get(i), hrInicial,
                                                hrFinal, medicoAux);
                                    }
                                    Facade.removerHorariosMedico(listaDiasSemana.get(indexDataFinal), hrInicial,
                                            medFal.getHoraFim(), medicoAux);
                                }
                            }

                            for (Consulta medCon : medicoAux.getListaConsultas()) {
                                cal.setTime(medCon.getDataHora());
                                int indexDataConsulta = (cal.get(GregorianCalendar.DAY_OF_WEEK) + iDomingo - 1) % 7;
                                 DiaDisponivelDTO diaDisponivel = Facade.removerHorariosMedico(listaDiasSemana.get(indexDataConsulta), medCon.getDataHora(),
                                        medCon.getDataHora(), medicoAux);
                                 listaDiasSemana.set(indexDataConsulta, diaDisponivel);
                            }
                        }

                    } else {
                        throw new Exception("Nao ha medicos disponiveis");
                    }
                    Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
                    String horariosJSON = gson.toJson(listaDiasSemana);
                    request.setAttribute("horarios", listaDiasSemana);
                    request.setAttribute("horariosJSON", horariosJSON);
                    request.setAttribute("tipoConsulta", especialidade);
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/resultado-pesquisa-consulta.jsp");
                    rd.forward(request, response);
                } catch (Exception ex) {
                    if (ex.getMessage().equals("Nao ha medicos disponiveis")) {
                        response.sendRedirect("ConsultaServlet?action=homePaciente&status=semMedicos");
                    }
                    try (PrintWriter out = response.getWriter()) {
                        out.println(ex.getMessage());
                    }
                }
            } else if ("ClinicaBuscaConsultasMedico".equals(action)) {
                try {
                    int idMedico = Integer.parseInt(request.getParameter("idMedico"));
                    Medico medico = Facade.buscarMedicoPorId(idMedico);
                    List<Consulta> consultas = Facade.buscarConsultasMedico(medico);
                    request.setAttribute("consultas", consultas);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/calendario-clinica.jsp");
                rd.forward(request, response);
            } else if ("BuscaConsultasMedico".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    List<Consulta> consultas = Facade.buscarConsultasMedico(medico);
                    request.setAttribute("consultas", consultas);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/calendario.jsp");
                rd.forward(request, response);
            } else if ("Dashboard".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    List<Consulta> consultas = Facade.buscarConsultasMedico(medico);
                    request.setAttribute("consultas", consultas);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/dashboard.jsp");
                rd.forward(request, response);
            } else if ("indisponibilidade".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    Medico medico = (Medico) session.getAttribute("usuario");
                    List<Consulta> consultas = Facade.buscarConsultasMedico(medico);
                    request.setAttribute("consultas", consultas);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/indisponibilidade.jsp");
                rd.forward(request, response);
            } else if ("homePaciente".equals(action)) {
                try {
                    HttpSession session = request.getSession();
                    PacienteUsuario pacienteUsuario = (PacienteUsuario) session.getAttribute("usuario");
                    List<Consulta> consultas = Facade.buscarConsultasPaciente(pacienteUsuario);
                    request.setAttribute("consultas", consultas);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(ConsultaServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/paciente-home.jsp");;
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
