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
import beans.MedicoHorario;
import beans.Login;
import beans.Medico;
import beans.MedicoFalta;
import beans.Paciente;
import beans.PacienteUsuario;
import daos.CidadeDAO;
import daos.ClinicaDAO;
import daos.ClinicaEnderecoDAO;
import daos.ConvenioDAO;
import daos.EnderecoDAO;
import daos.EspecialidadeDAO;
import daos.EstadoDAO;
import daos.HorarioDAO;
import daos.LoginDAO;
import daos.MedicoDAO;
import daos.PacienteDAO;
import daos.PacienteUsuarioDAO;
import java.sql.SQLException;
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

    public static void vincularMedicoClinica(int idMedico, int idClinicaEndereco) throws SQLException, ClassNotFoundException {
        ClinicaEnderecoDAO dao = new ClinicaEnderecoDAO();
        dao.vincularMedicoClinica(idMedico, idClinicaEndereco);
    }

    public static ClinicaEndereco getClinicaEnderecoPorId(int idClinicaEnd) throws SQLException, ClassNotFoundException {
        ClinicaEnderecoDAO dao = new ClinicaEnderecoDAO();
        return dao.buscaClinicaEnderecoPorId(idClinicaEnd);
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
        for(Medico medico : medicos){
            medico.setListaClinicaEndereco(dao.buscarMedicoClinicas(medico.getId()));
        }
        return medicos;
    }

    public static List<Consulta> buscarConsultasMedico(Medico medico) throws ClassNotFoundException, SQLException {
        HorarioDAO dao = new HorarioDAO();
        return dao.buscarConsultasMedico(medico);
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

    public List<Medico> carregaListaMedicos(int id) throws ClassNotFoundException, SQLException {
        MedicoDAO medicoDAO = new MedicoDAO();
        return medicoDAO.listaMedicosNaClinica(id);
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
    
    public static List<MedicoHorario> buscarHorariosConsulta(String especialidade, String cidade, String clinica) throws ClassNotFoundException, SQLException {
        HorarioDAO hDAO = new HorarioDAO();
        return hDAO.buscarHorariosConsulta(especialidade, cidade, clinica);
    }
    
    public static List<MedicoFalta> buscarFaltasSemana(Date dataInicio, Date dataFim, Integer idMedicos) throws ClassNotFoundException, SQLException {
        HorarioDAO hDAO = new HorarioDAO();
        return hDAO.buscarFaltasSemana(dataInicio, dataFim, idMedicos);
    }
    
    public static List<Consulta> buscarConsultasSemana(Date dataInicio, Date dataFim, Integer idMedicos) throws ClassNotFoundException, SQLException {
        HorarioDAO hDAO = new HorarioDAO();
        return hDAO.buscarConsultasSemana(dataInicio, dataFim, idMedicos);
    }
    
    public static void adicionarHorariosMedico(List<String> lista, Date horaIni, Date horaFim, Boolean add){
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(horaIni);
        Integer hIni = cal.get(GregorianCalendar.HOUR_OF_DAY);
        Integer mIni = cal.get(GregorianCalendar.MINUTE);
        cal.setTime(horaFim);
        Integer hFim = cal.get(GregorianCalendar.HOUR_OF_DAY);
        Integer mFim = cal.get(GregorianCalendar.MINUTE);
        
        for (Integer i=hIni; i<=hFim; i++){
            for (Integer j=mIni; j<=mFim; j+=30){
                String sAux = String.valueOf(i) +":"+ String.valueOf(j);
                if ((add) && (!lista.contains(sAux))){
                    lista.add(sAux);
                } else if (!add){
                    lista.remove(sAux);
                }
            }
        }
    }
    
    public static List<List<String>> instanciaListaHorarios(int dias){
        List<List<String>> listaMaster = new ArrayList();
        for (Integer i=1; i<=dias; i++){
            List<String> listaDetail = new ArrayList();
            listaMaster.add(listaDetail);
        }
        return listaMaster;
    }

    public List<PacienteUsuario> carregaListaPacientes(int idMedico) throws SQLException, ClassNotFoundException {
    PacienteDAO pacienteDAO = new PacienteDAO();
    return pacienteDAO.ListPacienteNoMedico(idMedico);
    }
}