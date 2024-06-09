package com.project.system.mapper;

import java.util.List;
import com.project.system.domain.SysUserHistory;

/**
 * 用户历史搜索记录 数据层
 *
 * @author Furui
 */
public interface SysUserHistoryMapper
{
    /**
     * 通过用户名查询历史搜索记录
     *
     * @param userName 用户名
     * @return 历史搜索记录集合
     */
    List<SysUserHistory> selectHistoryByUserName(String userName);

    /**
     * 新增历史搜索记录
     *
     * @param userHistory 用户历史搜索记录
     * @return 结果
     */
    int insertUserHistory(SysUserHistory userHistory);

    /**
     * 批量删除历史搜索记录
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    int deleteUserHistoryByIds(Long[] ids);

    /**
     * 删除单条历史搜索记录
     *
     * @param userHistory 用户历史搜索记录
     * @return 结果
     */
    int deleteUserHistoryInfo(SysUserHistory userHistory);
}
