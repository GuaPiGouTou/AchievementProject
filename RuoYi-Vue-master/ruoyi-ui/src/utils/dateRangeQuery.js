export function buildDateRangeQuery(queryParams, rangeMap) {
  const params = {
    ...queryParams,
    params: {
      ...(queryParams.params || {})
    }
  }

  Object.keys(rangeMap).forEach((key) => {
    delete params.params[`begin${key}`]
    delete params.params[`end${key}`]

    const range = rangeMap[key]
    if (Array.isArray(range) && range.length === 2 && range[0] && range[1]) {
      params.params[`begin${key}`] = range[0]
      params.params[`end${key}`] = range[1]
    }
  })

  return params
}
