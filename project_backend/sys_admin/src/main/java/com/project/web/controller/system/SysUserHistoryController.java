package com.project.web.controller.system;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.project.common.core.controller.BaseController;
import com.project.common.core.domain.AjaxResult;
import com.project.system.domain.SysUserHistory;
import com.project.system.service.ISysUserHistoryService;

/**
 * 历史记录
 *
 * @author Furui
 */

@RestController
@RequestMapping("/system/history")
public class SysUserHistoryController extends BaseController {
    @Autowired
    private ISysUserHistoryService userHistoryService;

//    @PreAuthorize("@ss.hasPermi('system:history:add')")
    @PostMapping("/add")
    public AjaxResult add(@RequestBody SysUserHistory userHistory) {
        return toAjax(userHistoryService.insertUserHistory(userHistory));
    }

//    @PreAuthorize("@ss.hasPermi('system:history:list')")
    @GetMapping("/list/{userName}")
    public AjaxResult list(@PathVariable String userName) {
        List<SysUserHistory> list = userHistoryService.selectHistoryByUserName(userName);
        return AjaxResult.success(list);
    }
}
