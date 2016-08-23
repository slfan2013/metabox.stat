#' samplesize_onefactormultipairedgroupspower
#'
#' stat
#' @param
#' @keywords
#' @export
#' @examples
#' samplesize_onefactormultipairedgroupspower()

samplesize_onefactormultipairedgroupspower <- function(m = 3,effectsize=0.8,sig_level = 0.05,power=0.8,corr=0.5,epsilon=0.75){
  df1 = (m - 1)*epsilon
  mu = m/(1-corr)
  p.body = quote({
    ncp = effectsize^2 * mu * N
    df2 = (N-1)*(m-1)*epsilon
    pf(qf(sig_level,df1,df2,lower.tail = F),df1,df2,ncp,lower.tail = F)
  })
  return(ceiling(tryCatch(uniroot(function(N) eval(p.body) - power, c(m +
                                                                 1e-10, 1e+05))$root*1,error = function(e){return("NA")})))
}