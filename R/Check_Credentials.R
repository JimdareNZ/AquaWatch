Check_Credentials <- function(handle = ""){

  resp <- curl::curl_fetch_memory(
    "https://us-central1-riverwatch-be1e4.cloudfunctions.net/api/alpha/sites",
    handle = handle
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
