# AquaWatch

An R client for the AquaWatch water quality monitoring API.

The **AquaWatch** package provides authenticated access to AquaWatch RiverWatch
devices, enabling discovery of available monitoring sites and retrieval of
time-filtered sample data for analysis and visualisation in R.

<p align="center">
  <img src="logo.png" alt="AquaWatch logo" width="200"/>
</p>

---

## Installation

    #use devtools to install from github
    install.packages("devtools")
    devtools::install_github("JimdareNZ/AquaWatch")

    library(AquaWatch)

---

## Quick start

    # create an authenticated curl handle
    h <- Handle_Generator("YOUR_API_TOKEN")

    # verify the credentials are valid
    Check_Credentials(h)

    # list available sites
    sites <- AW_Sites(handle = h)
    str(sites)

    # retrieve sample data
    eui <- sites$eui[1]

    # download samples within a specified time frame
    samples <- AW_Samples(
      eui,
      handle   = h,
      time_min = "2025-10-01",
      time_max = "2026-01-10"
    )

---

## Example: tidy and plot data

    library(tidyverse)

    samples %>%
      mutate(DateTime = ymd_hms(sampleTime, tz = "etc/GMT-12")) %>%
      pivot_longer(
        cols = 5:9,
        names_to = "Parameter",
        values_to = "Value"
      ) %>%
      ggplot(aes(x = DateTime, y = Value, colour = Parameter)) +
      geom_path() +
      facet_wrap(~Parameter, scales = "free_y", ncol = 1) +
      theme_bw()

---

## Design notes

- Authentication is handle-based, not global.
- All API calls require an explicit `curl_handle`.
- No credentials are stored internally or written to disk.
- Functions fail fast on HTTP errors and surface API response messages.

---

## Author

James Dare  
AquaWatch Solutions  
Email: james.d@aquawatchsolutions.com  

---

## License

MIT License. See `LICENSE` for details.
