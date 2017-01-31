# http://technews.tw/2017/01/23/x-files-from-cia/
# This is new CIA Freedom of Information Act (FOIA) Electronic Reading Room (ERR),
# called project 'CREST'': https://www.cia.gov/library/readingroom/collection/crest-25-year-program-archive

require(xml2)

#============================================================================#
#================= Get basic information of a given query ===================#
#============================================================================#
basic.info.query.CIA_CREST <- function(query){
  # try-catch: to avoid unexpect error
  tryCatch({
    # combine CIA url and your query
    init.url = paste('https://www.cia.gov/library/readingroom/search/site/', query, sep='')

    # read the html page
    html.page = read_html(url(init.url))
    
    # use 'xpath' to get the number of search items
    xpath = "//*[@class='current-search-item current-search-item-text current-search-item-results']" 
    search.items = xml_text(xml_find_all(html.page, xpath))
  
    # use 'xpath' to get the last page number
    xpath = "//*[@class='pager-last last']/a"
    last.page.url = xml_attr(xml_find_all(html.page, xpath), "href")
    last.page.num = strsplit(last.page.url, split="page=")[[1]][2]
    
    # print out basic information
    cat("The search query is for CIA Freedom of Information Act (FOIA) Electronic Reading Room (ERR)")
    cat("\n")
    cat("URL: https://www.cia.gov/library/readingroom/collection/crest-25-year-program-archive")
    cat("\n\n")
    cat(paste('Your query is : ', query, sep='')) 
    cat("\n")
    cat(search.items)
    cat("\n")
    cat(paste('The results contain 0 ~ ', last.page.num, ' pages', sep=''))
    cat("\n")
  }, # try-catch error
  error = function(e) {
    cat('Wrong query keywords or Unexpect error\n')
    cat(conditionMessage(e))
  }

  )
}

#============================================================================#
#================= Parse and return result table from CIA FOAI ERR===========#
#============================================================================#
parsing.pages.CIA_CREST <- function(query, pages){
  # try-catch: to avoid unexpect error
  tryCatch({
    # Search-Pages Array based on your.query and page.nums
    search.pages = paste('https://www.cia.gov/library/readingroom/search/site/', # basic url
                         paste(query, paste('page=', pages, sep=''), sep='?'), # query & pages
                         sep='')
    
    # Start parsing and return (title, url) from each page
    parse.table = data.frame()  # (title, url, page, corres.page) table
    for(page.url in search.pages){
      # read the html page
      html.page = read_html(url(page.url))
      
      # use 'xpath' to get (title, url) table for each page
      xpath = "//*[@class='search-results apachesolr_search-results']/li/h3/a"
      target = xml_find_all(html.page, xpath)
      # result table of current page
      current.page= data.frame(title = xml_text(target),                # title
                               download.url = unlist(xml_attr(target, "href")), # download url
                               page = pages[which(page.url == search.pages)],  # page num
                               correspond.page = page.url, # correspond.page.url
                               stringsAsFactors = F)
      
      # all results by combining each page 
      parse.table = rbind(parse.table, current.page)
    }
    cat('Success to return a parse.table')
    # return the final parse table after parsing
    parse.table
  }, # try-catch error
  error = function(e) {
    cat('Out of page range or Unexpect error\n')
    cat(conditionMessage(e))
  }
  
  )
}

#============================================================================#
#==== Download documents from talbe returned by parsing.pages.CIA_CREST() ===#
#============================================================================#

download.doc.CIA_CREST <- function(parse.table){
  # try-catch: to avoid unexpect error
  tryCatch({
    # download url should be chr type
    parse.table$`title` = as.character(parse.table$`title`)
    parse.table$`download.url` = as.character(parse.table$`download.url`)
    
    
    # reference table
    reference.table = data.frame()
    for(ind in 1:length(parse.table$`download.url`)){
      # read the html page
      html.page = read_html(url(parse.table$`download.url`[ind]))
      
      # use 'xpath' to get  for each page
      xpath = "//*[@class='odd']/td/span/a"
      target = xml_find_all(html.page, xpath)
      
      # documents information
      doc.name = as.character(xml_text(target))                
      doc.url = as.character(unlist(xml_attr(target, "href")))
      
      # the download page is not collection
      if(length(doc.name) == 1 ){
        download.file(doc.url, doc.name, method='auto', mode='wb')
        cur.table = data.frame(title = parse.table$`title`[ind],
                               pdf.name = doc.name,
                               stringsAsFactors = F)
        
        reference.table = rbind(reference.table, cur.table)
      }
      # the download page is collection, not handle yet
      else{}
    }
    
    cat('Success to download all files and return a reference.table')
    # return reference table (title, doc.name)
    write.csv(reference.table, 'reference_table.csv', row.names = F)
    reference.table
  }, # try-catch error
  error = function(e) {
    cat('Unexpect error\n')
    cat(conditionMessage(e))
    #print(ind)
    #print(parse.table$`title`[ind])
    #print(parse.table$`download.url`[ind])
  }
    
  )
}

