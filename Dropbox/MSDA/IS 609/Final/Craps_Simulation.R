
#pass bet
N = 10000

data = {}

for (i in 1:N){
  stop = FALSE
  
  shooter = sample(1:6,1) + sample (1:6,1)
  
  if (shooter == 12){
    data[i] = 0
    stop = TRUE
  }
  
  else if ((shooter == 7)||(shooter==11)){
    data[i] = 1
    stop = TRUE
  }
  
  else if ((shooter == 2)||(shooter==3)){
    data[i]=0
    stop = TRUE
  }
  
  else{
    point = shooter
  }
  
  repeat{
    if (stop){
      break
    }
    shooter = sample(1:6,1) + sample (1:6,1)
    
    if (shooter == 7){
      data[i]=0
      stop = TRUE
    }
    else if (shooter == point){
      data[i]=1
      stop = TRUE
    }
  }
}

#Probability of winning when you are a pass bet
mean(data)




#no-pass bet
N = 10000

data = {}

for (i in 1:N){
  stop = FALSE
  
  shooter = sample(1:6,1) + sample (1:6,1)
  
  if (shooter == 12){
    data[i] = 0
    stop = TRUE
  }
  
  else if ((shooter == 7)||(shooter==11)){
    data[i] = 0
    stop = TRUE
  }
  
  else if ((shooter == 2)||(shooter==3)){
    data[i]=1
    stop = TRUE
  }
  
  else{
    point = shooter
  }
  
  repeat{
    if (stop){
      break
    }
    shooter = sample(1:6,1) + sample (1:6,1)
    
    if (shooter == 7){
      data[i]=1
      stop = TRUE
    }
    else if (shooter == point){
      data[i]=0
      stop = TRUE
    }
  }
}

#Probability of winning when you are a pass bet
mean(data)
