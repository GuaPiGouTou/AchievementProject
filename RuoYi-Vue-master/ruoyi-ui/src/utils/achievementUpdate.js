export function cloneForm(data) {
  return JSON.parse(JSON.stringify(data || {}))
}

function normalizeCompareValue(value) {
  if (value === undefined) {
    return null
  }
  return value
}

function stringifyCompareValue(value) {
  const normalized = normalizeCompareValue(value)
  if (normalized !== null && typeof normalized === "object") {
    return JSON.stringify(normalized)
  }
  return String(normalized)
}

export function buildChangedPayload(current, original, idField, options = {}) {
  const excludeFields = new Set([
    idField,
    "userId",
    "deptId",
    "createdAt",
    "updatedAt",
    ...(options.excludeFields || [])
  ])
  const fields = options.fields || Array.from(new Set([
    ...Object.keys(original || {}),
    ...Object.keys(current || {})
  ])).filter(field => !excludeFields.has(field))

  const payload = { [idField]: current[idField] }
  fields.forEach(field => {
    if (excludeFields.has(field)) {
      return
    }
    if (stringifyCompareValue(current[field]) !== stringifyCompareValue(original[field])) {
      payload[field] = current[field]
    }
  })
  if (
    Object.keys(payload).length > 1 &&
    !Object.prototype.hasOwnProperty.call(payload, "auditStatus") &&
    current.auditStatus != null &&
    !excludeFields.has("auditStatus")
  ) {
    payload.auditStatus = current.auditStatus
  }
  return payload
}
