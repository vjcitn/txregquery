#'query TF data from Drill
#'@import GenomicRanges
#'@import mongolite
#'@import DrillR
#'@param mychr chromosome
#'@param mystart start position
#'@param myend end position
#'@param myfile path to TF file
#'@param myip system ip
#'@param myport port number
#'@export
getDrillTF<-function(mychr, mystart, myend, myfile,myip,myport=8047){
  require(DrillR)
  require(GenomicRanges)
  mydrill=rdrill(myip,myport)
  myquery=paste0("select FILENAME,columns[0] as chr, columns[1] as `start`, columns[2] as `end`, columns[6] as pvalue FROM dfs.`,myfile,` where columns[1] >= ",mystart," and columns[2] <=",myend," and columns[0]='chr",mychr,"'");
  myres=rd_query(mydrill,myquery)
  myres$start=as.numeric(myres$start)
  myres$end=as.numeric(myres$end)
  myres$pvalue=as.numeric(myres$pvalue)
  myres$FILENAME=as.character(myres$FILENAME)
  myres$chr=as.character(myres$chr)
  myrange=GRanges(myres$chr, IRanges(myres$start,myres$end ), mcols=myres[,c("FILENAME","pvalue")])
  myrange
  
}
