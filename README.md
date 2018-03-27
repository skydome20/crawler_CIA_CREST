[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Introduction    
   
2017/01/18, Central Intelligence Agency (CIA) released their CIA Records Search Tool(**CREST**) database online, including 930,000 declassified documents.   
   
Being interested, I try to write a web crawler for the public CIA CREST website ( https://www.cia.gov/library/readingroom/collection/crest-25-year-program-archive ), making it convenient to fast browse information of your query and automatically download documents in your own equipment.      
   
The search query is for CIA Freedom of Information Act (FOIA) Electronic Reading Room (ERR), and the crawler is coded by R.   

# crawler_CIA_CREST.R    

This is a R script which has 3 functions:    

1. `basic.info.query.CIA_CREST(query)` : get the basic information by a given query.   

2. `parsing.pages.CIA_CREST(query, pages)` : return a `parse.table` according to the given query and range of pages where you want to search, should be provied to the next function.   

3. `download.doc.CIA_CREST(parse.table)` : automatically download documents based on the `parse.table`, and return a `reference.table` which helps to match titles of documents with downloaded documents(.pdf).   

# main.R    

I provided some examples in this script, now just showing one example.   


## 1. basic.info.query.CIA_CREST(query)   

For example, if you are interesting in "secret lettet" and want to search some documents:   

```r
basic.info.query.CIA_CREST(query = "secret letter") 
```   

```
# Response 
The search query is for CIA Freedom of Information Act (FOIA) Electronic Reading Room (ERR)
URL: https://www.cia.gov/library/readingroom/collection/crest-25-year-program-archive

Your query is : secret letter
Search found 388350 items
The results contain 0 ~ 19417 pages
```

and you will get the response of **388350** search items and the range of result pages is **0~19417** pages.     

(Note that **0 page** equals to the first page on the web)   


## 2. parsing.pages.CIA_CREST(query, pages)   
    
The next step is to decide pages where you want to search.   

For example, you want to check documenets about "secret letter" in the top 10 pages: 

```r
your.query = 'secret letter'
page.nums = c(0:9)   # the top 10 pages

parse.table = parsing.pages.CIA_CREST(query = your.query, 
									  pages = page.nums)
```

The return `parse.table` includes 4 columns:

<img src="img/0.png" />    

1. `title` : titles of documents.

2. `download.url` : urls where to download documents.

3. `page` : the page where this document is in.

4. `correspond.page` : the page url where this documents is in.

This `parse.table` should be supplied to `download.doc.CIA_CREST()`, the function which will automatically download all documents in `parse.table` to the relative folder.


## 3. download.doc.CIA_CREST(parse.table)   

That is, we want to download documents(.pdf) about "secret letter" in the top 10 pages.

```r
your.query = 'secret letter'
page.nums = c(0:9)   # the top 10 pages

parse.table = parsing.pages.CIA_CREST(query = your.query, 
                                      pages = page.nums)
									  
reference.table = download.doc.CIA_CREST(parse.table)
```

Or we want to download the top 10 documents(.pdf) about "UFO" in the first page.

```r
your.query = 'UFO'
page.nums = c(0)   # the first pages

parse.table = parsing.pages.CIA_CREST(query = your.query, 
                                      pages = page.nums)
									  
reference.table = download.doc.CIA_CREST(parse.table[1:10,]) # only the top 10 documents  
```

Note that the return `reference.table` includs 2 columns, 

1. `title` : title of documents 

2. `pdf.name` : file name of downloaded documents(.pdf)

for the reason that downloaded documents have their own file name by CIA encoded style; therefore, it's necessary to have a `reference.table` for mathcing **titles** to **documents**.

<img src="img/1.png" />    


# R Note for more detail

I write an article in Chinese for more detail about how I implement this crawler.   
 
(Sorry, there is no English version)    

http://rpubs.com/skydome20/R-Note13-Web-Crawler-on-CIA-CREST-by-xml2     





