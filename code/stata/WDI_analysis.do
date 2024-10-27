import delimited "https://raw.githubusercontent.com/Ali-Duni/project_coding/refs/heads/main/data/clean/WDI_data_cleaned.csv"
describe
##since our dataset is already in the tidy format, which is more useful for our analysis, I am not going to transform it further
## let us now look at a basic descriptive table create some plots showing the relationship between our variables.
summarize 
##first, since the lowest year in our dataset is 1990, let us look at the relationship between child mortality and immunization in 1990
twoway (scatter infant_mortality immunization if year == 1990, msize(tiny)), title("Scatterplot of child mortality and immunization in country in year 1990")
mkdir "graphs"
graph export "graphs/mortality_immunization_1990.jpg", as(jpg)
##we can see that the general trend seems to be that the higher the immunization, the lower the mortality). Let's look how this looks in 2017, the most recent year
twoway (scatter infant_mortality immunization if year == 2017, msize(tiny)), title("Scatterplot of child mortality and immunization in country in year 2017")
graph export "graphs/mortality_immunization_2017.jpg", as(jpg)
## compared to 1990, immunization scores clearly got higher
##how about the link between child mortality and gdp?
twoway (scatter gdp infant_mortality if year == 2017, msize(tiny)), title("Scatterplot of child mortality and gdp in country in year 2017")
graph export "graphs/gdp_mortality_2017.jpg", as(jpg)
##let us break down our observations based on the decades. for this, we create a new variable called decade
generate decade = int(year/10)*10
browse
describe
## let us turn it into string, since it is a category
tostring decade, replace
## let's look at the means of worldwide immunization and infant mortality by decades
graph bar (mean) immunization infant_mortality, over (decade) title("Mean immunization and child mortality by decade")
graph export "graphs/decade_means.jpg", as(jpg)
##it looks like the immunization got slightly higher, whereas mortality has gotten significantly smaller 
##now, let us see correlations for each decade
preserve
collapse (mean) gdp immunization infant_mortality, by(decade)
list
restore
##finally, let us test the relationships between the variables using a simple correlation
correlate gdp immunization infant_mortality
##there is no need to save the data, as we will not be using them any further
