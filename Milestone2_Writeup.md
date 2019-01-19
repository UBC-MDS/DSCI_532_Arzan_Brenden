# Milestone 2 - Writeup  

### Rationale  

Our goal for this app was to provide the user with a tool that allowed them to compare the trend in violent crime rates of US cities over time, this is done on the `Total` tab of our app. To ensure a fair comparison, we have a line graph for both the raw and normalized crime numbers per 100k to adjust for differences in the populations between the two cities. To provide more granularity we also implemented four tabs, `Homicide`, `Rape`, `Robbery`, and `Aggravated Assault`. These tabs allow the user to compare specific categories of violent crime rates between the cities, again there are line plots for both raw and normalized crime numbers for a fair comparison between the cities.  

### Tasks  

The following tasks we had to complete for Milestone 2:

- Build `Total`, `Homicide`, `Rape`, `Robbery`, and `Aggravated Assault` tabs
  - Create side panel filter to allow the user to filter the crime data down to two cities
  - Create side panel filter to allow the user to filter the crime data down to specific years  
  - Create line plots for both raw and normalized crime numbers based on the currently selected tab
    - Ensure both plots would update to show the relevant information based on the selected tab
    - Ensure both plots y-labels would updated based on the selected tab
    - Ensure plot legends would update to show the selected cities  

### Vision & Next Steps  

Our goal for next week's milestone is to refine our selection controls for the cities. Currently the user must select two cities, but, we plan on updating this to allow them to select just single city at a time if they wish.  

### Bugs  

Currently our app has a few minor bugs:  
  1. The user can select the same city in both city pickers:  
    - We have to implemented logic to make the user select a city in the first dropdown first, then let them pick a second city that is not that same as the first one.
  2. When deploying our app to the shiny server the y-axis labels for both plots are using the variables names.  
    - We have to diagnose the cause of this issue and correct it.
