Handle_Generator <- function(token) {
  if (!nzchar(token)) stop("token is required")

  h <- curl::new_handle()
  curl::handle_setheaders(
    h,
    "Authorization" = paste("Bearer", token)
  )
  h
}
