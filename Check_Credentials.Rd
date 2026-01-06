\name{Check_Credentials}
\alias{Check_Credentials}
\title{
Check validity of AquaWatch API credentials
}
\description{
Tests whether an authenticated curl handle has valid access to the AquaWatch API
by issuing a request to the \code{/sites} endpoint and interpreting the HTTP
status code.
}
\usage{
Check_Credentials(Handle = "")
}
\arguments{
  \item{Handle}{
A \code{curl_handle} object created with \code{Handle_Generator()}.
}
}
\details{
This function performs a lightweight API call to verify authentication and
basic permissions. It does not download or store any site data.

The function interprets HTTP status codes into human-readable messages:
\itemize{
  \item{2xx: Successful authentication and access}
  \item{4xx: Client-side or permission error}
  \item{5xx: Server-side error}
}
}
\value{
A character string describing the result of the credential check, including
the HTTP status code returned by the API.
}
\seealso{
\code{\link{Handle_Generator}},
\code{\link[curl]{curl_fetch_memory}}
}
\examples{
\dontrun{
library(curl)

h <- Handle_Generator("YOUR_TOKEN")

Check_Credentials(h)
}
}
\keyword{utilities}
