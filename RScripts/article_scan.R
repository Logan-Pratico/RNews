
category <- commandArgs[length(commandArgs)]
commandArgs <- head(commandArgs, -1)
keywords <- commandArgs

dir.create(
  path = here("output", as.character(Sys.Date()), category), recursive = TRUE,
  showWarnings = FALSE
)

errorFile <- here("output", Sys.Date(), category, "errors.txt")
cat("ERRORS and WARNINGS:\n------------\n", file = errorFile, sep = "\n")




walk(urls, function(url) {
  message(url)

  result <- tryCatch(
    {
      items <- tidyfeed(url) %>%
        select(-starts_with("feed")) %>%
        select(contains("title"), contains("link"), contains("content"), contains("description")) %>%
        set_colnames(c("title", "url", "description"))
      walk(keywords, function(keyword) {
        filename <- here("output", Sys.Date(), category, paste0(keyword, ".csv"))
        keywords_list <-
          items %>%
          filter(
            str_detect(tolower(title), tolower(keyword)) |
              str_detect(tolower(description), tolower(keyword))
          ) %>%
          top_n(1)
        # {
        #   if (grepl("bbc", url) || grepl("nytimes", url)) top_n(., 1) else top_n(., 1)
        # }


        if (nrow(keywords_list) > 0) {
          write.table(keywords_list,
            file = filename,
            append = file.exists(filename),
            sep = ",",
            row.names = FALSE,
            col.names = !(file.exists(filename))
          )
        }
      })
    },
    warning = function(w) {
      cat(paste("WARNING:\n", w, "\nURL\n", url, "\n---------\n\n"),
        file = errorFile, append = TRUE
      )
    },
    error = function(e) {
      cat(paste("ERROR:\n", e, "\nURL\n", url, "\n---------\n\n"),
        file = errorFile, append = TRUE
      )
    },
    finally = {
      # Do Nothing
    }
  )
})

warnings()
