# Benford-s-Law-
This project is the continuation of the practice sql project where I Verify whether some parameters in the dataset follow Benford's Law 
### Benford's Law overview :
* If the leading digits of a number in dataset had equal probabilities for all digits 1-9 ,then each digit would occur 11.1% of the time 
* But in reality this is not the case. It began when Simon Newcomb noticed that the pages of a log book with smaller digits like 1,2 were more worn out than the other digits 
* This hypothesis was later tested by Frank Benford on 20 different Domains 
* The law states that in a dataset the leading digit with smaller value has a greater probability of occuring 
* Thus the probability distribution of digits in a dataset is not a straight line parallel to x axis but rather a hyperbola
* This property of nature or mathematics has been used to detect fraud in taxes,financial documents
* Following are the properties necessary for a dataset to follow Benford's Law.
  * Quantitative data.
  * Data that are measured rather than assigned.
  * Not artificially restricted by minimums or maximums.
  * Mixed populations.
  * Ranges over orders of magnitudes.
  * Larger datasets are better.
  
### Resources 
* Dataset : https://ourworldindata.org/covid-deaths 
* Packages/languages : SQL ,Tabluea,excel 
* Tableau visualizations: https://public.tableau.com/app/profile/vrashank.shetty/viz/BenfordsLaw_16863843986130/Dashboard1?publish=yes
* Websites :https://statisticsbyjim.com/probability/benfords-law/

### Exploratory Data Analysis 
* Derived 9 smaller datasets based on the Covid deaths dataset by the Count of appearance of each digits
* Unioned all the 9 datasets and since they are in ascending order assigned row number as the index which also works as the column indicating the digit
* Calcuated the percentage of each digits in the dataset
* Added a column consisting of the Benford's Law percentages to compare
* Plotted both, our dataset percentages and the Benford's law percentages
* ![alt text](https://github.com/svrashank/Benford-s-Law-/blob/New/Covid%20cases%20vs%20Benfords%20law.JPG 'New cases vs Benfords law percentage')
* ![alt text](https://github.com/svrashank/Benford-s-Law-/blob/New/Population%20vs%20Benfords%20law.JPG 'Population vs benfords law percentage')
* Benford's Law only works on first digits of a dataset ,to verify that I did all the same above steps for the last digits of new cases column
* Following are the results
* ![alt text](https://github.com/svrashank/Benford-s-Law-/blob/New/First%20vs%20last%20digit%20percentages.JPG 'First vs last digit percentage') 

### Observations 
* We see that the new cases column of the dataset follows benford's law very accurately
* Whereas not all digits of  population column follow benford's law
* There are less than 200 observations in the population column, hence one criteria of benford's law dataset is not met
* However the digit that was the most in population columnn still was 1
* The last digit of the dataset follows much more even distribution of percentages which indicates that it doesn't follow benford's law 




  

