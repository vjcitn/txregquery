#'query eQTL from mongodb
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
#' mystart=41196312-500*1000
#' myend=41322262+500*1000
#' res_eqtl=getMongoRangeEqtl(mychrGO,mystartGo,myendGo)
#' res_eqtl
#' }
#' @export
getMongoRangeEqtl<-function(mychr,mystart,myend,mycoll="Breast_Mammary_Tissue_Analysis.v6p.all_snpgene_pairs_eQTL",mydb="txregnet"){
  require(mongolite)
  require(GenomicRanges)
  my_collection = mongo(collection = mycoll, db = mydb) # connect
  myquery=paste0('{',
                 '"chr":',mychr,',',
                 '"snp_pos" : {"$gte":',mystart,'},',
                 '"snp_pos" : {"$lte":',myend,'}}')
  res=my_collection$find(myquery)
  myrange=GRanges(res$chr, IRanges(res$snp_pos, width = 1), mcols=res)
  myrange
  
}