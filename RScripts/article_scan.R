
 category <- commandArgs[length(commandArgs)]
 commandArgs <- head(commandArgs,-1)
 keywords <- commandArgs


walk(urls, function(url) {
  message(url)
  items <- tidyfeed(url) %>%
    select(-starts_with("feed")) %>%
    select(contains("title"), contains("link"), contains("content"), contains("description")) %>%
    set_colnames(c("title", "url", "description"))

 # print(items)

  walk(keywords, function(keyword) {
    dir.create(
      path = here("output", as.character(Sys.Date()), category), recursive = TRUE,
      showWarnings = FALSE
    )

    filename <- here("output", Sys.Date(), category, paste0(keyword, ".csv"))
    keywords_list <-
      items %>%
      filter(
        str_detect(tolower(title), tolower(keyword)) |
          str_detect(tolower(description), tolower(keyword))
      ) %>%
      {
        if (grepl("bbc", url) || grepl("nytimes", url)) top_n(., 1) else top_n(., 3)
      }


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
})

warnings()
