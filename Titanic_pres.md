Predict survival on the Titanic
========================================================
author: Vsevolod Demydov 
date: 2015, June 23

Task description
========================================================

On April 15, 1912, during her maiden voyage, the Titanic sank after colliding with an iceberg, killing 1502 out of 2224 passengers and crew.
__Input data__ - passangers information:

- Sex
- Age
- Ticket class
- Family onboard information
- etc (futher information at https://www.kaggle.com/c/titanic )

__Goal__ - predict passanger surviving status (survived/dead)

Data preparation
========================================================
1. Input data was download from https://www.kaggle.com/c/titanic/data (you need to be registered user in Kaggle to download, so if you want to copy model - copy file "train.csv" to the same folder)
2. Data was divided on teaching and testing parts (70% to 30%)
3. Useful data fields were selected (by correlation analysis)
4. All the missed data (there are a lot of missed fields) was substituted by mean value of non-missed values

Realized prediction models
========================================================
This task is well known classification problem (with 2 groups). 3 types of classification models were created:

- Support vertor machines (with linear kernel)
- Regression trees
- Random forest

Also Generalized Boosted Regression was created 

How to use / Comparing results
========================================================
Just check all the checkboxes that you want. Note that boosting (if checked) works with all the 3 models regardless to other checkboxes.
__Results__: different seeds give different results but
- accuracy of all methods are close to 0.8
- random forest usually better than regression trees
- boosting usually returns best of 3 results (I did not see better result than best of 3 methods)
