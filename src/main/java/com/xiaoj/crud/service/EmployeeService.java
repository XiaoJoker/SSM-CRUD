package com.xiaoj.crud.service;

import com.xiaoj.crud.bean.Employee;
import com.xiaoj.crud.bean.EmployeeExample;
import com.xiaoj.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.xiaoj.crud.bean.EmployeeExample.Criteria;

import java.util.List;
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    /**
    *查询所有员工
    */

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验员工用户名是否可用
     *
     * @param empName
     * @return true:代表用户名可用
     */
    public boolean checkUser(String empName){
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    /**
     * 按照员工ID查询员工
     * @return
     */

    public Employee getEmp(Integer id){
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
    /**
     *员工更新
     */

    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
    /**
     *员工删除
     */
    public void deleteEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }
    /**
     * 员工批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example=new EmployeeExample();
        Criteria criteria=example.createCriteria();
        //delete from xxx where empId in(1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);

    }
}
