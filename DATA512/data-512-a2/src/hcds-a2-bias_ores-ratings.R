########################################################################################################################
# PURPOSE AND METHODLOGY
########################################################################################################################
# Purpose: Assignment 2 of the DATA 512 MSDS course involves using an ORES algorithm to rate articles and two
  # options for python were presented, but neither worked on my machine despite much testing. I have instead
  # opted to do this portion in R, then simply read back into the python side.  This reduces reproducibility
  # since it's introducing two languages and two scripts, but seems to be necessary to get functioning.  

########################################################################################################################
# LOAD LIBRARIES AND SET PARAMETERS
########################################################################################################################
# The following code is based on user 'jtmorgan''s work in 
# https://github.com/Ironholds/data-512-a2/blob/master/hcde_a2_bias_r.ipynb, which has an MIT open license

library(httr)
library(magrittr)

user_agent <- "https://github.com/WrightWillT wtwright@uw.edu" #paramater for API call to ORES

########################################################################################################################
# GET DATA
########################################################################################################################
# Read in the page_data (only change from raw is that the template rows were removed)
page_data <- read.csv("../data_raw/page_data_nonTemplate.csv")

########################################################################################################################
# GET RATINGS
########################################################################################################################
# Define a single function that will happily take multiple revision IDs
get_ores_data <- function(revision_ids, user_agent){
  
  # Define the parameters, collapsing the revision IDs into a single string separated by | marks
  parameters <- list(models = "wp10",
                     revids = paste0(revision_ids, collapse = "|")
  )
  url <- "https://ores.wikimedia.org/v3/scores/enwiki/"
  
  # Make the query, check for an error, retrieve the content and convert it from JSON
  results <- httr::GET(url, query = parameters,  user_agent(user_agent)) %>%
    stop_for_status %>%
    content
  
  # Return the results
  return(results)
}

# set a maximum number of ids to send in each batch that doesn't exceed the API expectations
max_calls <- 100

# initialize output
results <- as.list(NULL)

# loop to send batches of max_calls' worth of revision ids and put them all together
# first part gets all the "full" lists of 100
for(i in 1:(ceiling(nrow(page_data)/max_calls)-1)){
  call_results <- get_ores_data(page_data$rev_id[((i-1)*max_calls+1):(i*max_calls)], user_agent) # 1-100, 101-200, etc
  results <- c(results, call_results)
}
# this part picks up the remainder
for(i in 1:(nrow(page_data)-(ceiling(nrow(page_data)/max_calls)-1)*100)){
  call_results <- get_ores_data(page_data$rev_id[((ceiling(nrow(page_data)/max_calls)-1)*100+1):
                                                   ((ceiling(nrow(page_data)/max_calls)-1)*100+i)], user_agent)
  results <- c(results, call_results)
}


# I'm not sure of a more clever (vectorized) way to do this so I'll loop through each of the 468 results lists and extract
# the components I want into a dataframe:
results_df <- setNames(data.frame(matrix(ncol = 2, nrow = nrow(page_data))), c("rev_id", "prediction"))
# outer loop goes through each of the api-calls (468) and inner loop goes through each rev_id within the call (all 100 except last)
for(i in 1:length(results)){
  for(j in 1:length(results[[i]][[2]])){
    results_df$rev_id[(i-1)*100+j] <- names(results[[i]][[2]][j]) #grabs the rev_id within the list structure
    results_df$prediction[(i-1)*100+j] <- results[[i]][[2]][[j]][[1]][[1]][[1]] #grabs prediction value
  }
}

# Replace all the the unique RevisionNotFound predictions with a single string
results_df$prediction[which(grepl("^RevisionNotFound.*",results_df$prediction))] <- "RevisionNotFound"

########################################################################################################################
# EXPORT DATA
########################################################################################################################
# write the results to .csv to be picked back up by python
write.csv(results_df, "../data_raw/page_data_predictions.csv", row.names = FALSE)



