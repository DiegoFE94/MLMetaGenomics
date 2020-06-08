machnlearn = function(path, patron, outputfile){
  #CARGADATOS
  require(mlr)
  l = list.files(path, pattern = patron)
  ldata = list()
  for (i in 1:length(l)) {
    ldata[[i]] = readRDS(paste(path, l[[i]], sep=''))
  }
  names(ldata) = l
  
  #TASK
  lista.tareas = list()
  for (i in 1:length(ldata)){
    lista.tareas[[i]] = makeClassifTask(id = paste('nfeat_',ncol(ldata[[i]])-1,sep=""),data = ldata[[i]],target = "target")
  }
  
  #SIN CF
  lista.sinCF = list()
  for (i in 1:length(lista.tareas)){
    lista.sinCF[[i]] = removeConstantFeatures(lista.tareas[[i]])
  }
  lista.Norm = list()
  for (i in 1:length(lista.sinCF)){
    lista.Norm[[i]] = normalizeFeatures(
      lista.sinCF[[i]],
      method = "range",
      cols = NULL,
      range = c(0, 1),
      on.constant = "quiet")
  }
  ###################################################################################
  bnchmarks = list()
  for (i in 1:length(lista.Norm)){
    ### Busqueda de hiperparámetros ###
    control = makeTuneControlGrid() # Establecer un control par los parametros del modelo
    inner = makeResampleDesc(method = "Holdout")#Optimizacion de los parametros del modelo usando un Holdout para despues utilizar un CV
    #RF#
    psRF = makeParamSet(makeDiscreteParam("mtry", values = c(round(sqrt(ncol(lista.Norm[[i]]$env$data)))-2,
                                                             round(sqrt(ncol(lista.Norm[[i]]$env$data))),
                                                             round(sqrt(ncol(lista.Norm[[i]]$env$data)))+2)),#Sumar dos y restar dos para tener un rango 
                        makeDiscreteParam("ntree", values= 1000L),
                        makeDiscreteParam("nodesize", values= c(1:3)))
    lrn2 = makeLearner("classif.randomForest",  predict.type = "prob")
    lrnRF = makeTuneWrapper(learner = lrn2, resampling = inner, measures = auc, par.set = psRF, control = control, show.info = T)
    
    #GLMNET#
    psGL = makeParamSet(makeDiscreteParam("lambda", values = c(0.0001,0.001,0.01,0.1,1)),
                        makeDiscreteParam("alpha",values = c(0,0.15,0.25,0.35,0.5,0.65,0.75,0.85,1)))
    lrn3 = makeLearner("classif.glmnet", predict.type = "prob")
    lrnGL = makeTuneWrapper(learner = lrn3, resampling = inner, measures = auc, par.set = psGL, control = control, show.info = T)
    
    learners = list(lrnRF, lrnGL)
    outer = makeResampleDesc(method = 'RepCV', predict = 'both', reps = 5, folds = 10, stratify = TRUE)
    ## Benchmarking ##
    bnchmarks[[i]] = benchmark(learners, lista.Norm[[i]], outer, measures = list(acc, auc, mmce), show.info = T , models = T)
  }
  bmrk = mergeBenchmarkResults(bnchmarks)
  saveRDS(bmrk, file= paste(outputfile,"Benchmark",patron,sep=""))
  return(bmrk)
}

#########################################################################################################################
varImp.glmnet = function(bmr, n.model){  
  models = getBMRModels(bmr)
  glmnet = models[[n.model]]$classif.glmnet.tuned #El nimero en models hace referecncia a la tanda de modelos de difernte numero de features es decir 2,4,6,7..               ,
  sum.betas = rep(0)
  for (model in 1:length(glmnet)) {
    learner.models = getLearnerModel(glmnet[[model]])
    sum.betas = sum.betas + as.vector((learner.models$learner.model$beta))
  }
  names(sum.betas) = glmnet[[n.model]]$features
  barplot(abs(sum.betas), main = 'Glmnet Variable Importance', xaxt = "n", ylim = c(0,10), col = topo.colors(length(sum.betas)))
  return(sum.betas)
}

###################################################################################################################
varImp.rf = function(bmr, n.model){
  models = getBMRModels(bmr)
  rf = models[[n.model]]$classif.randomForest.tuned
  sum.imp = rep(0)
  for (i in 1:length(rf)) {
    iters = getFeatureImportance(rf[[i]])
    res = as.matrix(iters$res)
    sum.imp =+ sum.imp + res
  }
  print(length(sum.imp))
  barplot(sum.imp, main = 'Random Forest Variable Importance', xaxt = "n", col = topo.colors(length(sum.imp)))
  return(sum.imp)
}