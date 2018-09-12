# get_mcf
An example of simple function for processing MCF data. Especially suitable for ecommerce.

Output of the function are the first and last source/campaign/keyword with you own exceptions.

## Usage
Be aware that you have googleAnalyticsR, googleAuthR and dplyr installed.

For example, run:
```R
get_mcf(df,c('(direct) / (none)', 'google / cpc'))
```

It will return the first and last source/campaign/keyword without (direct) / (none) and google / cpc.
