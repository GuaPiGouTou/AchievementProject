package com.ruoyi.attachment.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


public class ExportRequestDTO<T> {
    public List<String> getShowColumns() {
        return showColumns;
    }

    public void setShowColumns(List<String> showColumns) {
        this.showColumns = showColumns;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public ExportRequestDTO() {
    }

    public ExportRequestDTO(List<String> showColumns, T data) {
        this.showColumns = showColumns;
        this.data = data;
    }

    private List<String> showColumns;


    public List<Integer> getIds() {
        return Ids;
    }

    public void setIds(List<Integer> ids) {
        Ids = ids;
    }

    private List<Integer> Ids;
    private T data;


}
