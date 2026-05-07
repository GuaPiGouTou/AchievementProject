package com.ruoyi.common.utils;

import com.ruoyi.common.core.domain.AjaxResult;

import java.lang.reflect.Method;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class RemoteDateRangeFilter
{
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

    public interface PageFetcher
    {
        AjaxResult fetch(int pageNum, int pageSize);
    }

    public static class RangeField
    {
        private final String property;
        private final String suffix;

        private RangeField(String property)
        {
            this.property = property;
            this.suffix = capitalize(property);
        }

        public static RangeField of(String property)
        {
            return new RangeField(property);
        }
    }

    public static AjaxResult filterRemotePage(Map<String, Object> params, Integer pageNum, Integer pageSize,
                                             PageFetcher fetcher, RangeField... fields)
    {
        int currentPage = pageNum == null || pageNum < 1 ? 1 : pageNum;
        int currentSize = pageSize == null || pageSize < 1 ? 10 : pageSize;
        if (!hasRange(params, fields))
        {
            return fetcher.fetch(currentPage, currentSize);
        }

        AjaxResult countResult = fetcher.fetch(1, 1);
        int candidateTotal = getTotal(countResult);
        if (candidateTotal <= 0)
        {
            return filterAndPage(countResult, params, currentPage, currentSize, fields);
        }

        AjaxResult allResult = fetcher.fetch(1, candidateTotal);
        return filterAndPage(allResult, params, currentPage, currentSize, fields);
    }

    public static boolean hasRange(Map<String, Object> params, RangeField... fields)
    {
        if (params == null || params.isEmpty())
        {
            return false;
        }
        for (RangeField field : fields)
        {
            if (hasText(params.get("begin" + field.suffix)) || hasText(params.get("end" + field.suffix)))
            {
                return true;
            }
        }
        return false;
    }

    @SuppressWarnings("unchecked")
    public static AjaxResult filterAndPage(AjaxResult result, Map<String, Object> params, int pageNum, int pageSize,
                                           RangeField... fields)
    {
        Object rowsObject = result.get("rows");
        List<Object> rows = rowsObject instanceof List ? (List<Object>) rowsObject : Collections.emptyList();
        List<Object> filteredRows = new ArrayList<>();
        for (Object row : rows)
        {
            if (matches(row, params, fields))
            {
                filteredRows.add(row);
            }
        }

        int fromIndex = Math.max((pageNum - 1) * pageSize, 0);
        int toIndex = Math.min(fromIndex + pageSize, filteredRows.size());
        List<Object> pagedRows = fromIndex >= filteredRows.size()
                ? Collections.emptyList()
                : filteredRows.subList(fromIndex, toIndex);

        AjaxResult filteredResult = new AjaxResult();
        filteredResult.putAll(result);
        filteredResult.put("rows", pagedRows);
        filteredResult.put("total", filteredRows.size());
        return filteredResult;
    }

    public static int getTotal(AjaxResult result)
    {
        Object total = result.get("total");
        if (total instanceof Number)
        {
            return ((Number) total).intValue();
        }
        if (total != null)
        {
            try
            {
                return Integer.parseInt(String.valueOf(total));
            }
            catch (NumberFormatException ignored)
            {
                return 0;
            }
        }
        return 0;
    }

    private static boolean matches(Object row, Map<String, Object> params, RangeField... fields)
    {
        for (RangeField field : fields)
        {
            Object begin = params == null ? null : params.get("begin" + field.suffix);
            Object end = params == null ? null : params.get("end" + field.suffix);
            if (!hasText(begin) && !hasText(end))
            {
                continue;
            }

            Object value = readValue(row, field.property);
            if (!isInRange(value, begin, end))
            {
                return false;
            }
        }
        return true;
    }

    private static boolean isInRange(Object value, Object begin, Object end)
    {
        if (value == null)
        {
            return false;
        }
        LocalDateTime actual = parseDateTime(value, false);
        if (actual == null)
        {
            return false;
        }
        LocalDateTime beginTime = parseDateTime(begin, false);
        LocalDateTime endTime = parseDateTime(end, true);

        if (beginTime != null && actual.isBefore(beginTime))
        {
            return false;
        }
        return endTime == null || !actual.isAfter(endTime);
    }

    private static LocalDateTime parseDateTime(Object value, boolean endOfDay)
    {
        if (!hasText(value))
        {
            return null;
        }
        if (value instanceof Date)
        {
            return LocalDateTime.ofInstant(((Date) value).toInstant(), ZoneId.systemDefault());
        }

        String text = String.valueOf(value).trim();
        if (text.contains("."))
        {
            text = text.substring(0, text.indexOf('.'));
        }
        text = text.replace(' ', 'T');

        try
        {
            if (text.length() <= 10)
            {
                LocalDate date = LocalDate.parse(text, DATE_FORMATTER);
                return LocalDateTime.of(date, endOfDay ? LocalTime.MAX.withNano(0) : LocalTime.MIN);
            }
            return LocalDateTime.parse(text, DATE_TIME_FORMATTER);
        }
        catch (Exception ignored)
        {
            return null;
        }
    }

    @SuppressWarnings("rawtypes")
    private static Object readValue(Object row, String property)
    {
        if (row instanceof Map)
        {
            return ((Map) row).get(property);
        }
        String getterName = "get" + capitalize(property);
        try
        {
            Method getter = row.getClass().getMethod(getterName);
            return getter.invoke(row);
        }
        catch (Exception ignored)
        {
            return null;
        }
    }

    private static boolean hasText(Object value)
    {
        return value != null && !String.valueOf(value).trim().isEmpty();
    }

    private static String capitalize(String value)
    {
        if (value == null || value.isEmpty())
        {
            return value;
        }
        return value.substring(0, 1).toUpperCase() + value.substring(1);
    }
}
