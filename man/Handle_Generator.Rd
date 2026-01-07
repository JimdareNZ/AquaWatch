\name{Handle_Generator}
\alias{Handle_Generator}
\title{
Create an authenticated curl handle for the AquaWatch API
}
\description{
Creates and returns a \code{curl} handle with the \code{Authorization: Bearer <token>}
header set for use in AquaWatch API requests.
}
\usage{
Handle_Generator(token)
}
\arguments{
  \item{token}{
Character scalar. AquaWatch API token.
}
}
\details{
The returned handle can be passed to \code{curl::curl_fetch_memory()},
\code{curl::curl_fetch_disk()}, and related functions via the \code{handle}
argument. This function does not validate the token, it only formats and sets
the HTTP \code{Authorization} header.
}
\value{
A \code{curl_handle} object (as created by \code{curl::new_handle()}).
}
\seealso{
\code{\link[curl]{new_handle}},
\code{\link[curl]{handle_setheaders}},
\code{\link[curl]{curl_fetch_memory}}
}
\examples{
\dontrun{
library(curl)

h <- Handle_Generator("YOUR_TOKEN")

resp <- curl_fetch_memory(
  "https://us-central1-riverwatch-be1e4.cloudfunctions.net/api/alpha/sites",
  handle = h
)

resp$status_code
rawToChar(resp$content)
}
}
\keyword{utilities}
