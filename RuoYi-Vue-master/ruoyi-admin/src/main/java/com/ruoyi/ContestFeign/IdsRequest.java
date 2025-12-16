package com.ruoyi.ContestFeign;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.Arrays;

public class IdsRequest {
    public Long[] getIds() {
        return Ids;
    }

    public void setIds(Long[] Ids) {
        this.Ids = Ids;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getDeptId() {
        return deptId;
    }

    public void setDeptId(Long deptId) {
        this.deptId = deptId;
    }

    @Override
    public String toString() {
        return "IdsRequest{" +
                "Ids=" + Arrays.toString(Ids) +
                ", userId=" + userId +
                ", deptId=" + deptId +
                '}';
    }

    public IdsRequest( Long userId, Long deptId,Long[] Ids) {
        this.Ids = Ids;
        this.userId = userId;
        this.deptId = deptId;
    }
    @JsonProperty("Ids")
    private Long [] Ids;
    private Long userId;
    private Long deptId;
}
