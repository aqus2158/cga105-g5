package com.musclebeach.coachclassorder.model;

import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CoachClassOrderJDBCDAO implements CoachClassOrderDAO_interface {
    private static final String INSERT_STMT =
            "INSERT INTO coach_class_order (emp_id,mem_id,class_time,order_status,coach_class_period) VALUES ( ?, ?, ?, ?,?)";
    private static final String GET_ALL_STMT =
            "SELECT order_id,emp_id,mem_id,class_time,order_status,updatetime,createtime,coach_class_period FROM coach_class_order order by order_id";
    private static final String GET_ALL_STMTBYEMP =
            "SELECT order_id,emp_id,mem_id,class_time,order_status,updatetime,createtime,coach_class_period FROM coach_class_order where mem_id = ?";
    private static final String GET_ONE_STMT =
            "SELECT order_id,emp_id,mem_id,class_time,order_status,updatetime,createtime,coach_class_period FROM coach_class_order where order_id = ?";
    private static final String DELETE =
            "DELETE FROM coach_class_order where order_id = ?";
    private static final String UPDATE =
            "UPDATE coach_class_order set emp_id=?, mem_id=?, class_time=?, order_status=?, coach_class_period=?  where order_id = ?";
    private static final String GET_ALL_COACHPERIODBYEMPANDCLASSTIME =
            "SELECT coach_class_period FROM coach_class_order where (emp_id =? && class_time= ?)";
    String driver = "com.mysql.cj.jdbc.Driver";
    @Resource
    private DataSource dataSource;

    @Override
    public void insert(CoachClassOrderVO coachClassOrderVO) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(INSERT_STMT);

            pstmt.setInt(1, coachClassOrderVO.getEmpID());
            pstmt.setInt(2, coachClassOrderVO.getMemID());
            pstmt.setDate(3, coachClassOrderVO.getClassTime());
            pstmt.setInt(4, coachClassOrderVO.getOrderstatus());
            pstmt.setString(5, coachClassOrderVO.getCoachclassperiod());
            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver.�L�kŪ����Ʈw�X�ʵ{��insert "
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured.��Ʈw�o�Ϳ��~insert "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }

    @Override
    public void update(CoachClassOrderVO coachClassOrderVO) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(UPDATE);

            pstmt.setInt(1, coachClassOrderVO.getEmpID());
            pstmt.setInt(2, coachClassOrderVO.getMemID());
            pstmt.setDate(3, coachClassOrderVO.getClassTime());
            pstmt.setInt(4, coachClassOrderVO.getOrderstatus());
            pstmt.setString(5, coachClassOrderVO.getCoachclassperiod());
            pstmt.setInt(6, coachClassOrderVO.getOrderID());

            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. �L�kŪ����Ʈw�X�ʵ{��update"
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured. ��Ʈw�o�Ϳ��~update"
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }

    @Override
    public void delete(Integer orderID) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(DELETE);

            pstmt.setInt(1, orderID);

            pstmt.executeUpdate();

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver.�L�kŪ����Ʈw�X�ʵ{��delete "
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured.��Ʈw�o�Ϳ��~delete "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }

    }

    @Override
    public CoachClassOrderVO findByPrimaryKey(Integer orderID) {

        CoachClassOrderVO coachClassOrderVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(GET_ONE_STMT);

            pstmt.setInt(1, orderID);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                // empVo �]�٬� Domain objects
                coachClassOrderVO = new CoachClassOrderVO();
                coachClassOrderVO.setOrderID(rs.getInt("order_id"));
                coachClassOrderVO.setEmpID(rs.getInt("emp_id"));
                coachClassOrderVO.setMemID(rs.getInt("mem_id"));
                coachClassOrderVO.setCreateTime(rs.getTimestamp("createtime"));
                coachClassOrderVO.setOrderstatus(rs.getInt("order_status"));
                coachClassOrderVO.setClassTime(rs.getDate("class_time"));
                coachClassOrderVO.setUpdateTime(rs.getTimestamp("updatetime"));
                coachClassOrderVO.setCoachclassperiod(rs.getString("coach_class_period"));
            }

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver.��Ʈw�X�ʵ{�����~getpri "
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured.��Ʈw�o�Ͱ��Dgetpri "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }
        return coachClassOrderVO;
    }

    @Override
    public List<CoachClassOrderVO> getAllCoachPeriodByEmpAndClassTime(Integer empID, Date classtime) {
        List<CoachClassOrderVO> list = new ArrayList<CoachClassOrderVO>();
        CoachClassOrderVO coachClassOrderVO = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {


            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(GET_ALL_COACHPERIODBYEMPANDCLASSTIME);
            pstmt.setInt(1, empID);
            pstmt.setDate(2, classtime);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                //  也稱為 Domain objects
                coachClassOrderVO = new CoachClassOrderVO();
                coachClassOrderVO.setCoachclassperiod(rs.getString("coach_class_period"));
                list.add(coachClassOrderVO); // Store the row in the list
            }

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. "
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }
        return list;
    }

    @Override
    public List<CoachClassOrderVO> getAll() {
        List<CoachClassOrderVO> list = new ArrayList<CoachClassOrderVO>();
        CoachClassOrderVO coachClassOrderVO = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(GET_ALL_STMT);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                // empVO �]�٬� Domain objects
                coachClassOrderVO = new CoachClassOrderVO();
                coachClassOrderVO.setOrderID(rs.getInt("order_id"));
                coachClassOrderVO.setEmpID(rs.getInt("emp_id"));
                coachClassOrderVO.setMemID(rs.getInt("mem_id"));
                coachClassOrderVO.setCreateTime(rs.getTimestamp("createtime"));
                coachClassOrderVO.setOrderstatus(rs.getInt("order_status"));
                coachClassOrderVO.setClassTime(rs.getDate("class_time"));
                coachClassOrderVO.setUpdateTime(rs.getTimestamp("updatetime"));
                coachClassOrderVO.setCoachclassperiod(rs.getString("coach_class_period"));
                list.add(coachClassOrderVO); // Store the row in the list
            }

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. "
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }
        return list;
    }

    @Override
    public List<CoachClassOrderVO> getAllbyMem(Integer memid) {
        List<CoachClassOrderVO> list = new ArrayList<CoachClassOrderVO>();
        CoachClassOrderVO coachClassOrderVO = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {

            Class.forName(driver);
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(GET_ALL_STMTBYEMP);
            pstmt.setInt(1, memid);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                // empVO �]�٬� Domain objects
                coachClassOrderVO = new CoachClassOrderVO();
                coachClassOrderVO.setOrderID(rs.getInt("order_id"));
                coachClassOrderVO.setEmpID(rs.getInt("emp_id"));
                coachClassOrderVO.setMemID(rs.getInt("mem_id"));
                coachClassOrderVO.setCreateTime(rs.getTimestamp("createtime"));
                coachClassOrderVO.setOrderstatus(rs.getInt("order_status"));
                coachClassOrderVO.setClassTime(rs.getDate("class_time"));
                coachClassOrderVO.setUpdateTime(rs.getTimestamp("updatetime"));
                coachClassOrderVO.setCoachclassperiod(rs.getString("coach_class_period"));
                list.add(coachClassOrderVO); // Store the row in the list
            }

            // Handle any driver errors
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Couldn't load database driver. "
                    + e.getMessage());
            // Handle any SQL errors
        } catch (SQLException se) {
            throw new RuntimeException("A database error occured. "
                    + se.getMessage());
            // Clean up JDBC resources
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException se) {
                    se.printStackTrace(System.err);
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.err);
                }
            }
        }
        return list;
    }
}