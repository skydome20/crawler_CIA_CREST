source("crawler_CIA_CREST.R")

##################################################################################

# Download CIA files of 'Kennedy' in top 10 pages  

#=== 1. Give a query to get basic information ===#
basic.info.query.CIA_CREST(query = "Kennedy") 

#=== 2. Parse results according to given query and pages ===#
your.query = 'Kennedy'
page.nums = c(0:9)    # top 10 pages (note that 0 is the 1st page on the web)
# return a parse.table
parse.table = parsing.pages.CIA_CREST(your.query, page.nums)

#=== 3. Auto-download files according to the parse.table ===#
# download files according to the parse.table from parsing.pages.CIA_CREST()
# and return a reference.table
reference.table = download.doc.CIA_CREST(parse.table)


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



##################################################################################

# Download CIA files of 'Obama' in 0~1 pages  
# (note that 0 is the 1st page on the web)
#=== 1. Give a query to get basic information ===#
basic.info.query.CIA_CREST(query = "Obama") 

#=== 2. Parse results according to given query and pages ===#
your.query = 'Obama'
page.nums = c(0,1)    # 0~1 pages (note that 0 is the 1st page on the web)
parse.table = parsing.pages.CIA_CREST(your.query, page.nums)

#=== 3. Auto-download files according to the parse.table ===#
reference.table = download.doc.CIA_CREST(parse.table)

##################################################################################

# Download CIA files of 'UFO' in 0 pages 
# (note that 0 is the 1st page on the web)

#=== 1. Give a query to get basic information ===#
basic.info.query.CIA_CREST(query = "UFO") 

#=== 2. Parse results according to given query and pages ===#
your.query = 'UFO'
page.nums = c(0)    #  (note that 0 is the 1st page on the web)
parse.table = parsing.pages.CIA_CREST(your.query, page.nums)

#=== 3. Auto-download files according to the parse.table ===#
reference.table = download.doc.CIA_CREST(parse.table)
