pexefun = function(steP , endvec, funclist){
  x = seq(from = 0, to = max(endvec), by = steP)
  id = rep(0, length(x))
  for(i in 1 : length(id)){
    id[i] = 1
    for(j in 1 : length(endvec)){
      if(x[i] > endvec[j]){
        id[i] = id[i] + 1
      }
      else{
        break
      }
    }
  }
  #Apply functions
  y = rep(0, length(x))
  for(i in 1 : length(x)){
    y[i] = funclist[[id[i]]](x[i])
  }
  a = list(x, y)
  names(a) = c("x", "y")
  return (a)
}
