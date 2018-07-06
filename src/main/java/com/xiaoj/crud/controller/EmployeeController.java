package com.xiaoj.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaoj.crud.bean.Employee;
import com.xiaoj.crud.bean.MSG;
import com.xiaoj.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    /**
     * 删除员工
     * 改造成能批量删除的方法
     * 批量删除使用id，之间用-隔开
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public MSG deleteEmp(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            List<Integer> del_ids =new ArrayList<>();
            //将ids转化为id集合的字符数组
            String[] str_ids = ids.split("-");
            //组装id的集合，将字符数组转化为整型列表
            for (String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            //单个id就进行强转
            //parseInt可以将字符串进行解析
            //0x开头，转化为16位；0开头，转化为8位；1-9开头，转化为10位
            //也可使用parseInt(string,radix)指定需要解析的数字的基数
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return MSG.success();
    }


    /**
     * 更新员工
     * @param employee
     * @param request
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public MSG saveEmp(Employee employee,HttpServletRequest request){
        System.out.println("将要更新的员工数据" + employee);
        employeeService.updateEmp(employee);
        return MSG.success();
    }

    /**
     * 根据id查询员工
     * @param id
     * @return
     */
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public MSG getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return MSG.success().add("emp",employee);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public MSG checkUser(@RequestParam("empName")String empName){
        //先判断用户名是否合法
        String regEmpName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!empName.matches(regEmpName)){
            return MSG.fail().add("va_msg","用户名必须是6-16位的英文数字组合或者2-5位中文");
        }
        boolean b = employeeService.checkUser(empName);
        if(b){
            return MSG.success();
        }else{
            return MSG.fail();
        }
    }

    /**
     * 定义员工保存
     * 1.支持JSR303校验
     *2.导入hibernate-validator
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    //valid 代表封装对象里面的数据需要进行校验
    public MSG saveEmp(@Valid Employee employee,BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框显示错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println( "错误的字段名：" + fieldError.getField());
                System.out.println( "错误信息：" + fieldError.getDefaultMessage());
            }
            return MSG.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return MSG.success();
        }
    }

    /**
     *
     * 导入jackson包
     * @param pn
     * @return
     */
    //处理emps请求
    @RequestMapping("/emps")
    @ResponseBody
    public MSG getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        // 这不是一个分页查询
        // 引入pageHelper分页插件
        // 在查询之前只需要调用,传入页码以及每页大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
        // 封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
        // list.jsp调用pageInfo得到数据
        PageInfo page = new PageInfo(emps,5);
        return MSG.success().add("pageInfo",page);
    }
    /**
     * 查询员工数据（分页查询）
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 这不是一个分页查询
        // 引入pageHelper分页插件
        // 在查询之前只需要调用,传入页码以及每页大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
        // 封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
        // list.jsp调用pageInfo得到数据
        //PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo", new PageInfo(emps,5));
        // return list.jsp,在dispatcher-servlet中配置返回请求的前缀WEB-INF/view和后缀.jsp
        return "list";
    }
}
