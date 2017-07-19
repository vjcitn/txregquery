#'query Footprint data from mongodb
#'@import GenomicRanges
#'@import mongolite
#'@param mychr chromosome
#'@param mystart start position
#'@param myend end position
#'@param mycoll collection name in mongodb
#'@param mydb database name in mongodb
#'@examples
#'\dontrun{
#' mychrGo=17
#' mystartGo=41196312-500*1000
#' myendGo=41322262+500*1000
#' res_fp=getMongoRangeFp(mychrGo,mystartGo,myendGo)
#' res_fp
#' }
#' @export
getMongoRangeFp<-function(mychr,mystart,myend,mycoll="vHMEC_DS18406_footprint",mydb="txregnet"){
  require(mongolite)
  require(GenomicRanges)
  my_collection = mongo(collection = mycoll, db = mydb) # connect
  myquery=paste0('{',
                 '"chr":"',mychr,'",',
                 '"start" : {"$gte":',mystart,'},',
                 '"end" : {"$lte":',myend,'}}')
  res=my_collection$find(myquery)
  myrange=GRanges(res$chr, IRanges(res$start, res$end), mcols=res)
  myrange
  
}
