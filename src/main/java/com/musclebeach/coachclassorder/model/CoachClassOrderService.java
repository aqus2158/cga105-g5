package com.musclebeach.coachclassorder.model;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.sql.Date;
import java.util.List;

@Service
public class CoachClassOrderService {
    @Resource
    private CoachClassOrderDAO_interface dao;

    public CoachClassOrderVO addCoach(Integer empID, Integer memID, java.sql.Date classTime, Integer orderstatus, String coachclassperiod) {

        CoachClassOrderVO coachClassOrderVO = new CoachClassOrderVO();
        coachClassOrderVO.setEmpID(empID);
        coachClassOrderVO.setMemID(memID);
        coachClassOrderVO.setClassTime(classTime);
        coachClassOrderVO.setOrderstatus(orderstatus);
        coachClassOrderVO.setCoachclassperiod(coachclassperiod);
        dao.insert(coachClassOrderVO);

        return coachClassOrderVO;
    }

    public CoachClassOrderVO updateEmp(Integer orderid, Integer empID, Integer memID, java.sql.Date classTime, Integer orderstatus, String coachclassperiod) {

        CoachClassOrderVO coachClassOrderVO = new CoachClassOrderVO();

        coachClassOrderVO.setEmpID(empID);
        coachClassOrderVO.setMemID(memID);
        coachClassOrderVO.setClassTime(classTime);
        coachClassOrderVO.setOrderstatus(orderstatus);
        coachClassOrderVO.setOrderID(orderid);
        coachClassOrderVO.setCoachclassperiod(coachclassperiod);
//		coachClassOrderVO.getUpdateTime();
        dao.update(coachClassOrderVO);

        return getOneEmp(orderid);
    }

    public void deleteEmp(Integer orderid) {
        dao.delete(orderid);
    }

    public CoachClassOrderVO getOneEmp(Integer orderid) {
        return dao.findByPrimaryKey(orderid);
    }

    public List<CoachClassOrderVO> getAll() {
        return dao.getAll();
    }

    public List<CoachClassOrderVO> getAllCoachPeriodByEmpAndClassTime(Integer empid, Date coachdate) {
        return dao.getAllCoachPeriodByEmpAndClassTime(empid, coachdate);
    }

    public List<CoachClassOrderVO> getAllbyMem(Integer memid) {
        return dao.getAllbyMem(memid);
    }
}
