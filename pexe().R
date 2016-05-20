pexe = function(time, event){
  df = data.frame(time, event)
  colnames(df) = c("time", "event")
  df = df[order(df$time), ]
  
  
  #Distribute all the items into failure intervals
  df$No.interval = rep(0, nrow(df))#place holder
  for(i in 1 : nrow(df)){
    #Number of observed failures so far
    df$No.interval[i] = nrow(subset(df[1:i, ],df[1:i, ]$event== 1))
    if(df$event[i] == 0){
      df$No.interval[i] = df$No.interval[i] + 1
    }
  }
  
  
  #Items at risk from time 0 to the time before last failure
  df$n = seq(from = nrow(df), to = 1)
  
  
  #Calculate time period between two consecutive event(not including events happen at the same time)
  df$period = rep(0, nrow(df))#place holder
  df$period[1] = df$time[1]
  for(i in 2 : nrow(df)){
    if(df$time[i] == df$time[i-1]){
      df$period[i] = df$period[i-1]
    }
    else{
      df$period[i]=df$time[i]-df$time[i-1]
    }
  }
  
  #Split data by failure intervals
  df_split = split(df,df$No.interval)
  
  
  #Calculate failure rate
  failrate = rep(0, length(df_split))#place holder
  for(i in 1 : (length(df_split)-1)){
    a = split(df_split[[i]], df_split[[i]]$time)
     #Create 2 vectors. One stores time intervals, one stores n. The failure rate within one failure interval is 1/sum(vector.n*vector.period)
    p=rep(0, length(a))
    nmean = rep(0, length(a))
    for(j in 1 : length(a)){
      p[j] = a[[j]]$period[1]
      nmean[j] = mean(a[[j]]$n)
    }
    failrate[i] = 1 / sum(p * nmean)
  }
  
  
  
  #Creat table of failure rate
  interval = rep("", length(df_split))
  start = rep(0, length(df_split))
  end = rep(0, length(df_split))
  start[1] = 0
  end[1] = max(df_split[[1]]$time)
  interval[1] = paste('[', start[1], ',', end[1], ']', sep = "")
  
  for(i in 2 : length(df_split)){
    start[i] = max(df_split[[i-1]]$time)
    end[i] = max(df_split[[i]]$time)
    interval[i]=paste('(', start[i], ',', end[i], ']',sep = "")
  }

  failrtable = data.frame(interval,failrate)
  colnames(failrtable) = c("Time Interval", "Failure Rate")
  

  #Create a list of function pieces
  funlist = list()
  funcoe = rep(0, length(failrate)-1)
  funlist[[1]] = function(x){
    return (exp(-failrate[1]*x))
  }
  
  for(i in 2 : length(failrate)){
    funcoe[i-1] = funlist[[i-1]](end[i-1])
    a = paste("function(x){ return (funcoe[", i-1, "]*exp(-failrate[", i, "]*(x-end[", i-1, "])))}", sep='')
    funlist[[i]]=eval(parse(text = a))
  }

  l = list(start, end, failrate, failrtable, funlist)
  names(l) = c("start", "end", "failrate", "failrtable", "funlist")
  return(l)
}
