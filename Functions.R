##### Set Aquawatch Token ##"CE7Otvb9XShYRfe7xoxT"

Handle_Generator <- function(token) {
  library(curl)

  if (missing(token) || !nzchar(token)) stop("token is required")

  h <- new_handle()
  handle_setheaders(
    h,
    "Authorization" = paste("Bearer", token)
  )
  h
}


#h <- Handle_Generator(token = "CE7Otvb9XShYRfe7xoxT")


Check_Credentials <- function(Handle = ""){

  resp <- curl_fetch_memory(
    "https://us-central1-riverwatch-be1e4.cloudfunctions.net/api/alpha/sites",
    handle = Handle
  )

  status = resp$status_code


  if(status %in% c(200, 201, 202, 204)){
    return(paste0("Success: ",status))
  }
  else if(status %in% c(400, 401,403, 404, 408, 409, 410, 422, 429)){
    return(paste0("There is something wrong with the request or your permission: ",status))
  }
  else if(status %in% c(500,502,503,504)){
      return(paste0("There is a server-side error.  Retry or report to AquaWatch: ",status))
  }
  else{
    return(paste0("Unknown ID code: ", status))
    }


  }

Check_Credentials(Handle = h)






resp$status_code
rawToChar(resp$content)



library(curl)
library(jsonlite)


##function to get sites for token
aw_get <- function(path, query = NULL) {
  url <- paste0(
    "https://us-central1-riverwatch-be1e4.cloudfunctions.net/api/alpha/",
    path
  )

  if (!is.null(query)) {
    qs <- paste(
      paste(names(query), query, sep = "="),
      collapse = "&"
    )
    url <- paste0(url, "?", qs)
  }

  h <- new_handle()
  handle_setheaders(
    h,
    "Authorization" = paste("Bearer", Sys.getenv("AQUAWATCH_API_TOKEN"))
  )

  resp <- curl_fetch_memory(url, handle = h)

  if (resp$status_code != 200) {
    stop("HTTP ", resp$status_code, ": ", rawToChar(resp$content))
  }

  fromJSON(rawToChar(resp$content), simplifyVector = TRUE)
}


#Wrapper
aw_sites <- function() {
  aw_get("sites")
}


sites <- aw_sites()



aw_samples <- function(
    device_id,
    limit = NULL,
    time_min = NULL,   # POSIXct, Date, or ISO string
    time_max = NULL,   # POSIXct, Date, or ISO string
    order = "desc",
    timezone = "etc/GMT-12"
) {
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

  aw_get(paste0(device_id, "/samples"), q)
}


s <- aw_samples(sites$eui[1], time_min = as.Date("2025-11-01"), time_max = as.Date("2025-12-31"))



library(tidyverse)

  s %>%
  mutate(DateTime = ymd_hms(sampleTime, tz = "etc/GMT-12")) %>%
  ggplot()+
  geom_path(aes(x=DateTime,y=dissolvedOxygen))+
  theme_bw()







