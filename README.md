# get_mcf
An example of simple function for processing MCF data. Especially suitable for ecommerce.

Output of the function are the first and last sources/campaigns/keywords with you own exceptions.

## Usage
Be aware that you have googleAnalyticsR, googleAuthR and dplyr installed.

For example, run:
```R
get_mcf(df,c('(direct) / (none)', 'google / cpc'))
```

It will return the first and last sources/campaigns/keywords without (direct) / (none) and google / cpc.

```
 transactionId  firstSource             lastSource              firstCampaign               lastCampaign        
 <chr>           <chr>                   <chr>                   <chr>                       <chr>               
 1 16951206      (direct) / (none)       (direct) / (none)       (unavailable)               (unavailable)       
 2 16951216      (direct) / (none)       (direct) / (none)       (unavailable)               (unavailable)       
 3 16951236      (direct) / (none)       (direct) / (none)       (unavailable)               (unavailable)       
 4 16951246      (direct) / (none)       (direct) / (none)       (unavailable)               (unavailable)  
 ```
