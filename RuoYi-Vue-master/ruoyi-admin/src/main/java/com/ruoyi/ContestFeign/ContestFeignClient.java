package com.ruoyi.ContestFeign;

import com.ruoyi.competition.domain.AchievementsCompetition;
import com.ruoyi.competition.domain.demo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/*@FeignClient(value = "gateway-service", url = "http://172.16.46.77:1234") // 使用服务名，如果直接调用可用url属性指定完整URL
public interface ContestFeignClient {

    @GetMapping("/api/selectContestList")
    AchievementsCompetition getContestList(@RequestParam("userId") Long userId, @RequestParam("deptId") Long deptId);
}*/
@FeignClient(value = "gateway-service", url = "https://jsonplaceholder.typicode.com/") // 使用服务名，如果直接调用可用url属性指定完整URL
public interface ContestFeignClient {

    @GetMapping("/posts")
    List<demo> getContestList(@RequestParam("userId") Long userId, @RequestParam("id") Long deptId);
    @PostMapping("/posts")
    demo upContestList(@RequestBody demo demo);
    @PostMapping(value = "/posts", consumes = "application/x-www-form-urlencoded")
    demo createPostForm(@RequestParam("title") String title,
                                       @RequestParam("body") String body,
                                       @RequestParam("userId") Long userId);
}