AW_Samples <- function(
    eui,
    handle,
    limit = NULL,
    time_min = NULL,   # POSIXct, Date, or ISO string
    time_max = NULL,   # POSIXct, Date, or ISO string
    order = "desc",
    timezone = "etc/GMT-12"
) {
  if (missing(handle) || is.null(handle)) stop("handle is required")

  as_iso <- function(x) {
    if (is.null(x)) return(NULL)
    if (inherits(x, "POSIXt")) return(format(as.POSIXct(x, tz = timezone), "%Y-%m-%dT%H:%M:%S"))
    if (inherits(x, "Date"))   return(format(x, "%Y-%m-%d"))
    as.character(x)  # assume already ISO string
  }

  q <- list(
    limit  = limit,
    after  = as_iso(time_min),
    before = as_iso(time_max),
    order  = order
  )
  q <- q[!vapply(q, is.null, logical(1))]

  AW_Get(paste0(eui, "/samples"), query = q, handle = handle)
}
