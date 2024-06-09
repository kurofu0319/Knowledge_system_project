package com.project.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 用户历史搜索记录 sys_user_history
 *
 * @author Furui
 */
public class SysUserHistory
{
    /** 主键ID */
    private Long id;

    /** 用户名 */
    private String userName;

    /** 搜索关键词 */
    private String searchKeyword;

    /** 搜索结果 */
    private String results;

    /** 搜索时间 */
    private String searchTime;

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getSearchKeyword()
    {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword)
    {
        this.searchKeyword = searchKeyword;
    }

    public String getResults()
    {
        return results;
    }

    public void setResults(String results)
    {
        this.results = results;
    }

    public String getSearchTime()
    {
        return searchTime;
    }

    public void setSearchTime(String searchTime)
    {
        this.searchTime = searchTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("userName", getUserName())
                .append("searchKeyword", getSearchKeyword())
                .append("results", getResults())
                .append("searchTime", getSearchTime())
                .toString();
    }
}
