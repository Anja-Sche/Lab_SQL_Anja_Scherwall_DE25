# Analysis of sakila database


## Background
The purpose is to use knowledge of SQL and relational database to find insights from DVD rental data. There is data stored in a sqlite database and is to be migrated to a duckdb database.


When migrated, some data will be analyzed and the insights will be presented.


## DLT - data load tool
DLT is a way to ingest data from different sources into different destinations. In this project DLT is used to load data from an sqlite database into a duckdb database.


In the .py file I have built different paths. One to the file from where you extract the data and two paths, to duckdb databases, where the data is to be inserted. One database for the analysis and one for the dashboard.


Also in the .py file two pipelines are created, one for each database to give the data a destination.


## Analysis
For the analysis I worked in jupiter notebook to show the result of the sql-querys straight away. \
Some queries were requested by The Manager and others from questions I found interesting.


Two queries are shown by graphs using matplotlib. This gives a better visualization of the statistics.


## Dashboard
I used 'Evidence' as the tool to build the dashboard. It is an open framework for building products with SQL.


The dashboard has a mix of graphs and tables to visualize the result of the analysis. They are complimented with information that you can choose to take part of by clicking on the 'more information' text. This gives the reader a way of understanding the graph or table and what they are presenting.


The areas that are visualized are statistics on lengths of movies, the actors who have played in the most movies and some analysis on revenue.


Here is an example of a graph:


![](Bild_dashboard.png)