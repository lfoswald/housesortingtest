install.packages('rsconnect')
rsconnect::setAccountInfo(name='name',
                          token='XXXXXXXXXXXX',
                          secret='XXXXXXXXXXXXX')


# if changes to the app.R --> run this to update
library(rsconnect)
rsconnect::deployApp('~/R/housesortingtest')
