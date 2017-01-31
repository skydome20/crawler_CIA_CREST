# Introduction    
   
In 2017/01/18, Central Intelligence Agency (CIA) released their CIA Records Search Tool(**CREST**) database online, including 930,000 declassified documents.   
   
Briefly interesting, I try to write a web crawler for the public CIA CREST website(https://www.cia.gov/library/readingroom/collection/crest-25-year-program-archive), making it convenient to fast browse information of your query and automatically download documents in your own equipment.      
   
The search query is for CIA Freedom of Information Act (FOIA) Electronic Reading Room (ERR), and the crawler is coded by R.   

# crawler_CIA_CREST.R    

This is a R script which has 3 functions:    

1. basic.info.query.CIA_CREST(query) : get the basic information by a given query.   

2. parsing.pages.CIA_CREST(query, pages) : return a parse.table according to the given query and range of pages where you want to search.   

3. download.doc.CIA_CREST(parse.table) : automatically download documents in the parse.table, and return a reference.table which helps to match titles of documents with downloaded documents(.pdf).   

# main.R    

I provided some examples in this scripts 

```
##################################################################################

# Download CIA files of 'secret letter' in 0,2,4 pages  
# (note that 0 is the 1st page on the web)

#=== 1. Give a query to get basic information ===#
basic.info.query.CIA_CREST(query = "secret letter") 

#=== 2. Parse results according to given query and pages ===#
your.query = 'secret letter'
page.nums = c(0,2,4)    
# return a parse.table
parse.table = parsing.pages.CIA_CREST(your.query, page.nums)

#=== 3. Auto-download files according to the parse.table ===#
# download files according to the parse.table from parsing.pages.CIA_CREST()
# and return a reference.table
reference.table = download.doc.CIA_CREST(parse.table)

```