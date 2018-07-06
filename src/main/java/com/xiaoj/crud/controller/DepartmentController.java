package com.xiaoj.crud.controller;

import com.xiaoj.crud.bean.Department;
import com.xiaoj.crud.bean.MSG;
import com.xiaoj.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;
    /**
     * 返回所有部门信息
     */
    //处理depts请求
    @RequestMapping("/depts")
    @ResponseBody
    public MSG getDepts(){
        //查出的所有部门信息
        List<Department> list = departmentService.getDepts();
        return MSG.success().add("depts",list);
    }

}
