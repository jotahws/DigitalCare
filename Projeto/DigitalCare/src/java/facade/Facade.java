/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facade;

import beans.Cidade;
import beans.Clinica;
import beans.ClinicaEndereco;
import beans.Consulta;
import beans.Convenio;
import beans.ConvenioPaciente;
import beans.Endereco;
import beans.Especialidade;
import beans.Estado;
import beans.Falta;
import beans.MedicoHorario;
import beans.Login;
import beans.Medicamento;
import beans.Medico;
import beans.MedicoFalta;
import beans.Paciente;
import beans.PacienteUsuario;
import beans.Prontuario;
import daos.CidadeDAO;
import daos.ClinicaDAO;
import daos.ClinicaEnderecoDAO;
import daos.ConsultaDAO;
import daos.ConvenioDAO;
import daos.EnderecoDAO;
import daos.EspecialidadeDAO;
import daos.EstadoDAO;
import daos.FaltaDAO;
import daos.HorarioDAO;
import daos.LoginDAO;
import daos.MedicamentoDAO;
import daos.MedicoDAO;
import daos.PacienteDAO;
import daos.PacienteUsuarioDAO;
import daos.ProntuarioDAO;
import dtos.ConsultaDisponivelDTO;
import dtos.DiaDisponivelDTO;
import dtos.HorarioDisponivelDTO;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class Facade {

    public static PacienteUsuario buscarPacienteUsuarioPorIdLogin(int id) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO pacienteUsuarioDAO = new PacienteUsuarioDAO();
        return pacienteUsuarioDAO.buscarPacienteUsuarioPorIdLogin(id);
    }
    
    public static PacienteUsuario getPacienteUsuarioPorIdPaciente(int idPaciente) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO dao = new PacienteUsuarioDAO();
        return dao.buscarPacienteUsuarioPorIdPaciente(idPaciente);
    }
    
    public static Medico getMedicoPorLogin(int idLogin) throws SQLException, ClassNotFoundException {
        MedicoDAO dao = new MedicoDAO();
        return dao.getMedicoPorLogin(idLogin);
    }

    public static List<Especialidade> getListaEspecialidadesMedico(int idMedico) throws ClassNotFoundException, SQLException {
        EspecialidadeDAO especialidadeDAO = new EspecialidadeDAO();
        return especialidadeDAO.buscarEspecialidadesPorMedico(idMedico);
    }

    public static List<Convenio> getListaConveniosMedico(int id) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        return convenioDAO.buscarConveniosPorMedico(id);
    }

    public static List<Convenio> getListaConvenios() throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        return convenioDAO.buscarConvenios();
    }

    public static Clinica getClinicaPorLogin(int idLogin) throws ClassNotFoundException, SQLException {
        ClinicaDAO clinicaDAO = new ClinicaDAO();
        return clinicaDAO.buscarClinicaPorLogin(idLogin);
    }
    
    public static Clinica getClinicaPorID(int idClinica) throws ClassNotFoundException, SQLException {
        ClinicaDAO clinicaDAO = new ClinicaDAO();
        return clinicaDAO.buscarClinicaPorID(idClinica);
    }

    public static List<ClinicaEndereco> getListaEnderecosClinica(int idClinica) throws ClassNotFoundException, SQLException {
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        return enderecoDAO.buscarEnderecosClinica(idClinica);
    }

    public static List<Especialidade> listarEspecialidades() throws ClassNotFoundException, SQLException {
        EspecialidadeDAO especialidadeDAO = new EspecialidadeDAO();
        return especialidadeDAO.buscarEspecialidades();
    }

    private static void deletarEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        EnderecoDAO dao = new EnderecoDAO();
        dao.deletarEndereco(endereco);
    }

    public static List<ConvenioPaciente> getListaConveniosPaciente(int id) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        return convenioDAO.buscarConveniosPorPaciente(id);
    }

    public static List<Clinica> listarClinicas() throws ClassNotFoundException, SQLException {
        ClinicaDAO dao = new ClinicaDAO();
        return dao.listarClinicas();
    }

    public static List<Cidade> getCidadesPorNomeParcial(String nome) throws ClassNotFoundException, SQLException {
        CidadeDAO dao = new CidadeDAO();
        return dao.buscarCidadesPorNomeParcial(nome);
    }

    public static Medico getMedicoPorCPF(String cpf) throws SQLException, ClassNotFoundException {
        MedicoDAO dao = new MedicoDAO();
        return dao.getMedicoPorCPF(cpf);
    }
    
    public static Paciente getPacientePorCPF(String cpf) throws SQLException, ClassNotFoundException {
        PacienteDAO dao = new PacienteDAO();
        return dao.getPacientePorCPF(cpf);
    }

    public static void vincularMedicoClinica(int idMedico, int idClinicaEndereco) throws SQLException, ClassNotFoundException {
        ClinicaEnderecoDAO dao = new ClinicaEnderecoDAO();
        dao.vincularMedicoClinica(idMedico, idClinicaEndereco);
    }

    public static ClinicaEndereco getClinicaEnderecoPorId(int idClinicaEnd) throws SQLException, ClassNotFoundException {
        ClinicaEnderecoDAO dao = new ClinicaEnderecoDAO();
        return dao.buscaClinicaEnderecoPorId(idClinicaEnd);
    }

    public static List<ClinicaEndereco> getClinicaEnderecoPorMedico(Medico medico) throws SQLException, ClassNotFoundException {
        ClinicaEnderecoDAO dao = new ClinicaEnderecoDAO();
        return dao.buscaClinicaEnderecoPorMedico(medico);
    }

    public static MedicoHorario inserirHorarioDisponivel(MedicoHorario horarioDisponivel) throws SQLException, ClassNotFoundException {
        HorarioDAO dao = new HorarioDAO();
        return dao.inserirHorario(horarioDisponivel);
    }

    public static void deletarHorarioDisponivel(MedicoHorario horarioDisponivel) throws SQLException, ClassNotFoundException {
        HorarioDAO dao = new HorarioDAO();
        dao.apagarHorario(horarioDisponivel);
    }

    public static List<MedicoHorario> ListaHorariosPorMedico(Medico medico) throws SQLException, ClassNotFoundException {
        HorarioDAO dao = new HorarioDAO();
        return dao.listaHorariosPorMedico(medico);
    }

    public static List<Medico> getMedicosPorNome(String nome) throws ClassNotFoundException, SQLException {
        MedicoDAO dao = new MedicoDAO();
        List<Medico> medicos = dao.buscarMedicosPorNome(nome);
        for (Medico medico : medicos) {
            medico.setListaClinicaEndereco(dao.buscarMedicoClinicas(medico.getId()));
        }
        return medicos;
    }

    public static List<Consulta> buscarConsultasMedico(Medico medico) throws ClassNotFoundException, SQLException {
        HorarioDAO dao = new HorarioDAO();
        return dao.buscarConsultasMedico(medico);
    }

    public static List<Consulta> buscarConsultasAtuaisPorClinica(Clinica clinica) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        return dao.buscarConsultasEmAndamentoPorClinica(clinica);
    }

    public static Consulta buscarProximaConsultaPorMedico(Medico medico) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        return dao.buscarProximasConsultasPorClinica(medico);
    }

    public static List<Consulta> buscarConsultasPaciente(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        HorarioDAO dao = new HorarioDAO();
        return dao.buscarConsultasPaciente(pacienteUsuario);
    }

    public static Consulta marcaConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        return dao.insereConsulta(consulta);
    }

    public static void cancelaConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        dao.cancelaConsulta(consulta);
    }

    public static Consulta iniciaConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        dao.iniciaConsulta(consulta);
        return Facade.getConsultaPorId(consulta);
    }

    public static void concluiConsulta(Consulta consulta) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        dao.concluiConsulta(consulta);
    }

    public static void pacienteEmEspera(Consulta consulta) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        dao.pacienteEmEspera(consulta);
    }

    public static List<String[]> buscarStatusPorMedicoNoDia(Medico medico) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        return dao.buscarStatusPorMedicoNoDia(medico);
    }

    public static List<String[]> buscarStatusPorClinicaNoDia(Clinica clinica) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        return dao.buscarStatusPorClinicaNoDia(clinica);
    }

    private static Consulta getConsultaPorId(Consulta consulta) throws ClassNotFoundException, SQLException {
        HorarioDAO dao = new HorarioDAO();
        return dao.buscarConsultaPorId(consulta);
    }
    
    public static Consulta getConsultaAtual(Medico medico) throws ClassNotFoundException, SQLException {
        HorarioDAO dao = new HorarioDAO();
        return dao.buscarConsultaAtualPorMedico(medico);
    }

    public static List<List<String[]>> getEstatisticasMedico(Medico medico) throws ClassNotFoundException, SQLException {
        ConsultaDAO dao = new ConsultaDAO();
        List<List<String[]>> estatisticas = new ArrayList();
        estatisticas.add(dao.getPacientesDaUltimaSemana(medico)); //retorna uma lista com 2 itens dentro
        estatisticas.add(dao.getTotalConcluido(medico)); //retorna uma lista com 1 item dentro
        estatisticas.add(dao.getDiaSemanaMaisConsultas(medico)); //retorna uma lista com 1 item dentro
        switch (Integer.parseInt(estatisticas.get(2).get(0)[0])) {
            case 1:
                estatisticas.get(2).get(0)[0] = "Domingo";
                break;//dom
            case 2:
                estatisticas.get(2).get(0)[0] = "Segunda-feira";
                break;//seg
            case 3:
                estatisticas.get(2).get(0)[0] = "Terça-feira";
                break;//ter
            case 4:
                estatisticas.get(2).get(0)[0] = "Quarta-feira";
                break;//qua
            case 5:
                estatisticas.get(2).get(0)[0] = "Quinta-feira";
                break;//qui
            case 6:
                estatisticas.get(2).get(0)[0] = "Sexta-feira";
                break;//sex
            case 7:
                estatisticas.get(2).get(0)[0] = "Sábado";
                break;//sab
        }
        estatisticas.add(dao.getTotalCancelado(medico)); //retorna uma lista com 1 item dentro
        int totalConsultas = Integer.parseInt(estatisticas.get(1).get(0)[0]) + Integer.parseInt(estatisticas.get(3).get(0)[0]);
        float percent = (Integer.parseInt(estatisticas.get(3).get(0)[0]) * 100.0f) / totalConsultas;
        if (Float.isNaN(percent)) {
            estatisticas.get(3).get(0)[0] = "0";
        } else {
            DecimalFormat df = new DecimalFormat("#.#");
            estatisticas.get(3).get(0)[0] = df.format(percent);
        }
        return estatisticas;
    }

    public static Consulta proximoPaciente(Medico medico) throws ClassNotFoundException, SQLException {
        Consulta consulta = Facade.buscarProximaConsultaPorMedico(medico);
        Consulta consultaAtual = Facade.getConsultaAtual(medico);
        if (consultaAtual != null) {
            Facade.concluiConsulta(consultaAtual);
        }
        return Facade.iniciaConsulta(consulta);
    }

    public static Falta setFalta(Falta falta) throws ClassNotFoundException, SQLException {
        FaltaDAO dao = new FaltaDAO();
        return dao.insereFalta(falta);
    }

    public List<Estado> listarEstados() throws ClassNotFoundException, SQLException {
        EstadoDAO dao = new EstadoDAO();
        return dao.listarEstados();
    }

    public Cidade getCidadePorId(int id) throws ClassNotFoundException, SQLException {
        CidadeDAO dao = new CidadeDAO();
        return dao.buscarCidade(id);
    }

    public Cidade getCidadePorNome(String nome) throws ClassNotFoundException, SQLException {
        CidadeDAO dao = new CidadeDAO();
        return dao.buscarCidadeNome(nome);
    }

    public void inserirPacienteUsuario(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO dao = new PacienteUsuarioDAO();
        dao.inserirPacienteUsuario(pacienteUsuario);
    }

    public static int inserirEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        return enderecoDAO.inserirEndereco(endereco);
    }

    public static int inserirPaciente(Paciente paciente) throws ClassNotFoundException, SQLException {
        PacienteDAO pacienteDAO = new PacienteDAO();
        return pacienteDAO.inserirPaciente(paciente);
    }

    public static int inserirLogin(Login login) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.inserirLogin(login);
    }

    public static int inserirClinica(Clinica clinica) throws ClassNotFoundException, SQLException {
        ClinicaDAO clinicaDAO = new ClinicaDAO();
        return clinicaDAO.inserirClinica(clinica);
    }

    public int novaClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        ClinicaEnderecoDAO clinicaEnderecoDAO = new ClinicaEnderecoDAO();
        return clinicaEnderecoDAO.novaClinicaEndereco(clinicaEndereco);
    }

    public void inserirClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        ClinicaEnderecoDAO clinicaEnderecoDAO = new ClinicaEnderecoDAO();
        clinicaEnderecoDAO.inserirClinicaEndereco(clinicaEndereco);
    }

    public Login verificaLogin(Login login) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.buscarLogin(login);
    }

    public static Login buscaLoginPorId(int id) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.buscarLoginPorId(id);
    }

    public PacienteUsuario getPacientePorIdLogin(int id) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO pacUsuarioDAO = new PacienteUsuarioDAO();
        return pacUsuarioDAO.buscaPacientePorIdLogin(id);
    }

    public static Estado buscarEstadoPorId(int id) throws ClassNotFoundException, SQLException {
        EstadoDAO estadoDAO = new EstadoDAO();
        return estadoDAO.buscarEstadoPorId(id);
    }

    public static int inserirMedico(Medico medico) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.inserirMedico(medico);
    }

    public static int BuscarIdMedicoPorLogin(int idLogin) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.buscarIdMedicoPorLogin(idLogin);
    }

    public static void atualizarMedico(Medico medico) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.atualizarMedico(medico);
    }

    public void alteraPacienteUsuario(PacienteUsuario pacienteUsuario) throws SQLException, ClassNotFoundException {
        PacienteUsuarioDAO pacienteUsuarioDAO = new PacienteUsuarioDAO();
        pacienteUsuarioDAO.alteraDadosPaciente(pacienteUsuario);
    }

    public static void deletarMedicoEspecialidade(int idEspecialidade, int idMedico) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.deletarMedicoEspecialidade(idEspecialidade, idMedico);
    }

    public static void inserirMedicoEspecialidade(int idEspecialidade, int idMedico) throws SQLException, ClassNotFoundException {
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.inserirMedicoEspecialidade(idEspecialidade, idMedico);
    }

    public static void atualizarClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        ClinicaEnderecoDAO clinicaEnderecoDAO = new ClinicaEnderecoDAO();
        clinicaEnderecoDAO.atualizarClinicaEndereco(clinicaEndereco);
    }

    public static void atualizarClinica(Clinica clinica) throws ClassNotFoundException, SQLException {
        ClinicaDAO clinicaDAO = new ClinicaDAO();
        clinicaDAO.atualizarClinica(clinica);
    }

    public static void atualizarEndereco(Endereco endereco) throws ClassNotFoundException, SQLException {
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.atualizarEndereco(endereco);
    }

    public Boolean verificaSenhaPacienteUsuario(int id, String senha) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.verificaSenhaAtual(id, senha);
    }

    public void editaSenhaPacienteUsuario(PacienteUsuario pacienteUsuario, String novaSenha) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        loginDAO.atualizaSenhaPacienteUsuario(pacienteUsuario, novaSenha);
    }

    public void desativaConta(PacienteUsuario pacienteUsuario) throws ClassNotFoundException, SQLException {
        PacienteUsuarioDAO pacienteUsuarioDAO = new PacienteUsuarioDAO();
        pacienteUsuarioDAO.deletePacienteUsuario(pacienteUsuario);
    }

    public static List<Especialidade> buscarEspecialidadesMedico(int id) throws ClassNotFoundException, SQLException {
        EspecialidadeDAO especialidadeDAO = new EspecialidadeDAO();
        return especialidadeDAO.buscarEspecialidadesPorMedico(id);
    }

    public static int inserirEspecialidadeMedico(int idMedico, int idEspecialidade) throws ClassNotFoundException, SQLException {
        EspecialidadeDAO especialidadeDAO = new EspecialidadeDAO();
        return especialidadeDAO.inserirEspecialidadeMedico(idMedico, idEspecialidade);
    }

    public static void deletarEspecialidadesMedico(int idMedico) throws ClassNotFoundException, SQLException {
        EspecialidadeDAO especialidadeDAO = new EspecialidadeDAO();
        especialidadeDAO.deletarEspecialidadesMedico(idMedico);
    }

    public static Especialidade buscarEspecialidadePorId(int id) throws ClassNotFoundException, SQLException {
        EspecialidadeDAO especialidadeDAO = new EspecialidadeDAO();
        return especialidadeDAO.buscarEspecialidadePorId(id);
    }

    public static void deletarConveniosMedico(int idMedico) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        convenioDAO.deletarConveniosMedico(idMedico);
    }

    public static Convenio buscarConvenioPorId(int id) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        return convenioDAO.buscarConvenioPorId(id);
    }

    public static int inserirConvenioMedico(int idMedico, int idConvenio) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        return convenioDAO.inserirConvenioMedico(idMedico, idConvenio);
    }

    public static void deletarConveniosPaciente(int idPaciente) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        convenioDAO.deletarConveniosPaciente(idPaciente);
    }

    public static int inserirConvenioPaciente(ConvenioPaciente convenioPaciente) throws ClassNotFoundException, SQLException {
        ConvenioDAO convenioDAO = new ConvenioDAO();
        return convenioDAO.inserirConvenioPaciente(convenioPaciente);
    }

    public Boolean senhaVerificada(int id, String senha) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        return loginDAO.senhaAtualCorreta(id, senha);
    }

    public void editaSenha(int id, String novaSenha) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        loginDAO.atualizaSenha(id, novaSenha);
    }

    public void removerClinicaEndereco(ClinicaEndereco clinicaEndereco) throws ClassNotFoundException, SQLException {
        ClinicaEnderecoDAO dao = new ClinicaEnderecoDAO();
        dao.removerClinicaEndereco(clinicaEndereco);
        Facade.deletarEndereco(clinicaEndereco.getEndereco());
    }

    public List<Medico> carregaListaMedicos(int idClinica) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.listaMedicosNaClinica(idClinica);
    }

    public List<Medico> carregaListaMedicosUnique(int idClinica) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.listaMedicosNaClinicaUnique(idClinica);
    }

    public void desvinculaMedicoClinica(int idMedico, int idClinica) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.desvincularMedicoClinica(idMedico, idClinica);
    }

    public static void deletarLogin(int id) throws ClassNotFoundException, SQLException {
        LoginDAO loginDAO = new LoginDAO();
        loginDAO.deletarLogin(id);
    }

    public static void deletarMedicosSemClinica() throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        medicoDAO.deletarMedicosSemClinica();
    }

    public static Medico buscarMedicoPorId(int idLogin) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        Medico medico = medicoDAO.getMedicoPorLogin(idLogin);
        medico.setListaClinicaEndereco(medicoDAO.buscarMedicoClinicas(medico.getId()));
        return medico;
    }

    public PacienteUsuario carregaPerfilPaciente(int idMedico, int idPaciente) throws SQLException, ClassNotFoundException {
        PacienteDAO pacienteDAO = new PacienteDAO();
        return pacienteDAO.PacienteNoMedico(idMedico, idPaciente);
    }

    public static List<MedicoHorario> buscarHorariosConsulta(String especialidade, String cidade, String clinica, Medico medico) throws ClassNotFoundException, SQLException {
        HorarioDAO hDAO = new HorarioDAO();
        return hDAO.buscarHorariosConsulta(especialidade, cidade, clinica, medico);
    }

    public static List<MedicoFalta> buscarFaltasSemana(Date dataInicio, Date dataFim, Integer idMedicos) throws ClassNotFoundException, SQLException {
        HorarioDAO hDAO = new HorarioDAO();
        return hDAO.buscarFaltasSemana(dataInicio, dataFim, idMedicos);
    }
    
    public static List<Falta> buscarFaltas(Medico medico) throws ClassNotFoundException, SQLException, ParseException {
        FaltaDAO dao = new FaltaDAO();
        return dao.buscarFaltas(medico);
    }
    
    public static void apagarFaltas(Falta falta) throws ClassNotFoundException, SQLException {
        FaltaDAO dao = new FaltaDAO();
        dao.apagaFalta(falta);
    }

    public static List<Consulta> buscarConsultasSemana(Date dataInicio, Date dataFim, Integer idMedicos) throws ClassNotFoundException, SQLException {
        HorarioDAO hDAO = new HorarioDAO();
        return hDAO.buscarConsultasSemana(dataInicio, dataFim, idMedicos);
    }

    public static DiaDisponivelDTO removerHorariosMedico(DiaDisponivelDTO dia, Date horaIni, Date horaFim, Medico medico) {
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(horaIni);
        while (!(cal.getTime().after(horaFim))) {
            HorarioDisponivelDTO horarioDTO = dia.getDtoPorHorario(cal.getTime());
            ConsultaDisponivelDTO consultaDTO = horarioDTO.getConsultaDisponivelPorMedico(medico);
            dia.getDtoPorHorario(cal.getTime()).getListaConsultasDisponiveis().remove(consultaDTO);
            cal.add(GregorianCalendar.MINUTE, 30);
        }
        return dia;
    }

    public static List<DiaDisponivelDTO> instanciaListaDias(int dias, Date dataInicio) throws ParseException {
        List<DiaDisponivelDTO> listaMaster = new ArrayList();
        GregorianCalendar calDia = new GregorianCalendar();
        calDia.setTime(dataInicio);
        for (Integer i = 1; i <= dias; i++) {
            DiaDisponivelDTO diaDisponivel = new DiaDisponivelDTO();
            SimpleDateFormat format = new SimpleDateFormat("HH:mm");
            String str = "08:00";
            String str2 = "20:00";
            Date hrInicial = format.parse(str);
            Date hrFinal = format.parse(str2);
            GregorianCalendar cal = new GregorianCalendar();
            GregorianCalendar calFinal = new GregorianCalendar();
            cal.setTime(hrInicial);
            calFinal.setTime(hrFinal);
            while (!(cal.getTime().getTime() == calFinal.getTime().getTime())) {
                HorarioDisponivelDTO horario = new HorarioDisponivelDTO();
                horario.setHorario(cal.getTime());
                diaDisponivel.getListaHorariosDisponiveis().add(horario);
                cal.add(GregorianCalendar.MINUTE, 30);
            }
            diaDisponivel.setDia(calDia.getTime());
            listaMaster.add(diaDisponivel);
            calDia.add(GregorianCalendar.DAY_OF_MONTH, 1);
        }
        return listaMaster;
    }

    public static void adicionarHorariosMedico(DiaDisponivelDTO dia, MedicoHorario medHor) {
        ConsultaDisponivelDTO consultaDTO = new ConsultaDisponivelDTO();
        consultaDTO.setClinica(medHor.getClinicaEndereco());
        consultaDTO.setMedico(medHor.getMedico());
        GregorianCalendar cal = new GregorianCalendar();
        GregorianCalendar calFinal = new GregorianCalendar();
        cal.setTime(medHor.getHoraInicio());
        calFinal.setTime(medHor.getHoraFim());
        while (!(cal.getTime().getTime() == calFinal.getTime().getTime())) {
            HorarioDisponivelDTO horarioDTO = dia.getDtoPorHorario(cal.getTime());
            if (horarioDTO != null) {
                horarioDTO.getListaConsultasDisponiveis().add(consultaDTO);
            }
            cal.add(GregorianCalendar.MINUTE, 30);
        }
    }

    public List<PacienteUsuario> carregaListaPacientes(int idMedico) throws SQLException, ClassNotFoundException {
        PacienteDAO pacienteDAO = new PacienteDAO();
        return pacienteDAO.ListPacienteNoMedico(idMedico);
    }
    
    public static List<Medicamento> getMedicamento(Medicamento medicamento) throws SQLException, ClassNotFoundException {
        MedicamentoDAO dao = new MedicamentoDAO();
        return dao.buscar(medicamento);
    }
    
    public static void inserirProntuario(Prontuario prontuario) throws ClassNotFoundException, SQLException{
        ProntuarioDAO dao = new ProntuarioDAO();
        dao.criaProntuario(prontuario);
    }
    
    public static void inserirAtestado(Prontuario prontuario) throws ClassNotFoundException, SQLException{
        ProntuarioDAO dao = new ProntuarioDAO();
        dao.updateAtestado(prontuario);
    }

    public static void inserirReceita(Prontuario prontuario) throws ClassNotFoundException, SQLException {
        ProntuarioDAO dao = new ProntuarioDAO();
        dao.updateReceita(prontuario);
    }
    
    public static void inserirExame(Prontuario prontuario) throws ClassNotFoundException, SQLException {
        ProntuarioDAO dao = new ProntuarioDAO();
        dao.updateExame(prontuario);
    }
}
