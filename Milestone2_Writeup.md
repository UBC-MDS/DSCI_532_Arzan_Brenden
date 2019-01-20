# Milestone 2 - Writeup  

### Rationale  

Our goal for this app was to provide the user a visualization tool that allowed him/her to compare the trend in violent crime rates - between a pair of US cities - over time.  Since the data for each city was chronological, we found it most intuitive to visualize this time-series data as a line-chart. The colors we chose to contrast the two cities were from a colorblind friendly palette. This ensured that our user interface was more accessible. To ensure a fair comparison, we have a line graph for both the raw and normalized crime numbers per 100k to adjust for differences in the populations between the two cities. Apart from the `'Total` violent crimes, four other tabs for , `Homicide`, `Rape`, `Robbery`, and `Aggravated Assault` provides more granularity for the user. These tabs allow the user to compare specific categories of violent crime rates between the cities, again there are line plots for both raw and normalized crime numbers for a fair comparison between the cities.  

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
We would like to implement as many of the next steps as possible.
- Add functionality to compare more than 2 cities at a time
- Highlight certain points on the graph to provide time sensitive information
- Add tool tips to provide exact values and other information for each years
- Provide aggregated visualizations for selected time range

### Bugs  

Currently our app has a few minor bugs:  
  1. The user can select the same city in both city pickers:  
    - We have to implement logic to remove the city that the user selects in the first dropdown, from the second dropdown. This will allow us to ensure that the user cannot select the same city in both dropdowns.
  2. When deploying our app to the shiny server the y-axis labels for both plots are using the variables names.  
    - We have to diagnose the cause of this issue and correct it.
