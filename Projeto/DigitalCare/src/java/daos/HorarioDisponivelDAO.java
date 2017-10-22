/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.ClinicaEndereco;
import beans.HorarioDisponivel;
import beans.Medico;
import conexao.ConnectionFactory;
import facade.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author JotaWind
 */
public class HorarioDisponivelDAO {

    private final String inserirHorario = "INSERT INTO medico_horarios (id_medico_clinica, dia_semana, horario_inicio, horario_fim) \n"
            + "VALUES ((select id from medico_clinica mc where mc.id_medico = ? AND mc.id_clinica_endereco = ?),\n"
            + " ?, ?, ?);";
    
    private final String apagarHorario = "DELETE FROM medico_horarios WHERE id=?;";

    private final String listaHorariosPorMedico = "select * from medico_horarios mh \n"
            + "INNER JOIN medico_clinica mc ON mc.id = mh.id_medico_clinica \n"
            + "INNER JOIN medico m ON m.id = mc.id_medico \n"
            + "INNER JOIN clinica_endereco ce ON ce.id = mc.id_clinica_endereco \n"
            + "WHERE m.id = ? ORDER BY mh.horario_inicio;";

    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public final HorarioDisponivel inserirHorario(HorarioDisponivel horario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(inserirHorario, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, horario.getMedico().getId());
            stmt.setInt(2, horario.getClinicaEndereco().getId());
            stmt.setInt(3, horario.getDiaSemana());
            stmt.setTime(4, horario.getHoraInicio());
            stmt.setTime(5, horario.getHoraFim());
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                horario.setId(rs.getInt(1));
                return horario;
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }

    public void apagarHorario(HorarioDisponivel horario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(apagarHorario);
            stmt.setInt(1, horario.getId());
            stmt.executeUpdate();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public List<HorarioDisponivel> listaHorariosPorMedico(Medico medico) throws ClassNotFoundException, SQLException {
        try {
            List<HorarioDisponivel> lista = new ArrayList();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(listaHorariosPorMedico);
            stmt.setInt(1, medico.getId());
            rs = stmt.executeQuery();
            while (rs.next()) {
                ClinicaEndereco clinicaEndereco = Facade.getClinicaEnderecoPorId(rs.getInt("ce.id"));
                HorarioDisponivel horario = new HorarioDisponivel();
                horario.setId(rs.getInt("mh.id"));
                horario.setDiaSemana(rs.getInt("mh.dia_semana"));
                horario.setHoraFim(rs.getTime("mh.horario_fim"));
                horario.setHoraInicio(rs.getTime("mh.horario_inicio"));
                horario.setMedico(medico);
                horario.setClinicaEndereco(clinicaEndereco);
                lista.add(horario);
            }
            return lista;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }
}
