
# googleAuthR for fetching  data
library(googleAnalyticsR)
# googleAuthR for authorization
library(googleAuthR)
# dplyr for fun 
library(dplyr)

# authorization
ga_auth()

# view id of your Google Analytics view
ga_view  = "46195197"

# date range
start_date = "2017-10-01"
end_date = "2017-10-02"

# build query
df = google_analytics(id = ga_view, 
                               start = start_date, end = end_date, 
                               metrics = c("totalConversionValue"), 
                               dimensions = c("transactionId","sourceMediumPath","campaignPath"),
                               filters = 'mcf:conversionType==Transaction',
                               max=99999999,
                               type="mcf")

# function for processing
get_mcf = function(df, sources_to_del) {
  df$sourceMediumPath = gsub("CLICK|NA|:", "", df$sourceMediumPath)
  df$campaignPath = gsub("CLICK|NA|:", "", df$campaignPath)
  
  sourceList = strsplit(df$sourceMediumPath," > ")
  campaignList = strsplit(df$campaignPath ," > ")
  transactionIdList = as.list(df$transactionId)
  cList = mapply(cbind, transactionIdList, sourceList, campaignList)
  list_to_df = setNames(do.call(rbind, lapply(cList, data.frame, stringsAsFactors=FALSE)), c("transactionId", "sourceMediumPath", "campaignPath"))
  
  df_count = list_to_df %>% group_by(transactionId) %>% 
    summarise(count = n_distinct(sourceMediumPath)) %>% 
    left_join(list_to_df,.)
  
  df_filter = df_count[ifelse(df_count$count > 1,!df_count$sourceMediumPath %in% sources_to_del,TRUE),]
  
  df_final1 = df_filter %>% group_by(transactionId) %>% 
    summarise(
      firstSource = first(sourceMediumPath),
      lastSource = last(sourceMediumPath),
      firstCampaign = first(campaignPath),
      lastCampaign = last(campaignPath)
    ) %>% 
    select(transactionId,firstSource,lastSource,firstCampaign,lastCampaign)
  
  
  df_final2 = anti_join(df_count,df_final1) %>% 
    group_by(transactionId) %>% 
    summarise(
      firstSource = first(sourceMediumPath),
      lastSource = last(sourceMediumPath),
      firstCampaign = first(campaignPath),
      lastCampaign = last(campaignPath)
    )
  
  return(rbind(df_final1,df_final2))
  
}
