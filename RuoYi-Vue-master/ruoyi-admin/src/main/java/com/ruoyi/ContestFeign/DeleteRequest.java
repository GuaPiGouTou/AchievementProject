package com.ruoyi.ContestFeign;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class DeleteRequest {
    private Long userId;
    private Long deptId;
    private Long[] competitionIds;
}
