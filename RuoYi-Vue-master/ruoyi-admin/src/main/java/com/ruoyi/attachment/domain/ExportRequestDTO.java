package com.ruoyi.attachment.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Arrays;
import java.util.List;


public class ExportRequestDTO<T> {

    public List<String> getShowColumns() {
        return showColumns;
    }

    public void setShowColumns(List<String> showColumns) {
        this.showColumns = showColumns;
    }

    public Long[] getIdList() {
        return idList;
    }

    public void setIdList(Long[] idList) {
        this.idList = idList;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "ExportRequestDTO{" +
                "showColumns=" + showColumns +
                ", idList=" + Arrays.toString(idList) +
                ", data=" + data +
                '}';
    }

    public ExportRequestDTO(List<String> showColumns) {
        this.showColumns = showColumns;
    }

    private List<String> showColumns;
    private Long [] idList;
    private T data;

    public ExportRequestDTO() {
    }
}
