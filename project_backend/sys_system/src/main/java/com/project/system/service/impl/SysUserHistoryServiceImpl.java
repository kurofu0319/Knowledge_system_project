package com.project.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.system.domain.SysUserHistory;
import com.project.system.mapper.SysUserHistoryMapper;
import com.project.system.service.ISysUserHistoryService;

/**
 * 用户历史搜索记录 服务层实现
 *
 * @author Furui
 */
@Service
public class SysUserHistoryServiceImpl implements ISysUserHistoryService
{
    @Autowired
    private SysUserHistoryMapper userHistoryMapper;

    /**
     * 通过用户名查询历史搜索记录
     *
     * @param userName 用户名
     * @return 历史搜索记录集合
     */
    @Override
    public List<SysUserHistory> selectHistoryByUserName(String userName)
    {
        return userHistoryMapper.selectHistoryByUserName(userName);
    }

    /**
     * 新增历史搜索记录
     *
     * @param userHistory 用户历史搜索记录
     * @return 结果
     */
    @Override
    public int insertUserHistory(SysUserHistory userHistory)
    {
        return userHistoryMapper.insertUserHistory(userHistory);
    }

    /**
     * 批量删除历史搜索记录
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteUserHistoryByIds(Long[] ids)
    {
        return userHistoryMapper.deleteUserHistoryByIds(ids);
    }

    /**
     * 删除单条历史搜索记录
     *
     * @param userHistory 用户历史搜索记录
     * @return 结果
     */
    @Override
    public int deleteUserHistoryInfo(SysUserHistory userHistory)
    {
        return userHistoryMapper.deleteUserHistoryInfo(userHistory);
    }
}
