# install.packages("sqldf")
library(sqldf)
library(dplyr)
library(stringr)
library(ggplot2)
library(randomForest)
library(knitr)
library(caret)

#main------------------------------------------------------------------------------------------
#事前にF_preを読み込んでください
t_2014_add<-read.csv("C:/study/JLeague/motodata/2014_add.csv",
                     header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")

#addデータ追加
train_all <- dplyr::bind_rows(train, train_add)
condition_all <- dplyr::bind_rows(condition, condition_add)
test <- dplyr::bind_rows(test, t_2014_add)
anyNA(test)

#train/testの前処理実施
train_new <- F_pre(train_all,condition_all,stadium, traindataflag=TRUE)
test_new <- F_pre(test,condition_all,stadium, traindataflag=FALSE)
anyNA(test_new)

#############J1_2012
#データ作成
suii_J1_2012<- F_suii(train_new,2012,"Ｊ１",T)
suii_J1_2013<- F_suii(train_new,2013,"Ｊ１",T)
suii_train_J1_2014<- F_suii(train_new,2014,"Ｊ１",T)

suii_J2_2012<- F_suii(train_new,2012,"Ｊ２",T)
suii_J2_2013<- F_suii(train_new,2013,"Ｊ２",T)
suii_train_J2_2014<- F_suii(train_new,2014,"Ｊ２",T)

suii_test_J1_2014<- F_suii(test_new,2014,"Ｊ１",T)
suii_test_J2_2014<- F_suii(test_new,2014,"Ｊ２",T)


kensyo_J1_2012<- F_suii(train_new,2012,"Ｊ１",F)
kensyo_J1_2013<- F_suii(train_new,2013,"Ｊ１",F)
kensyo_train_J1_2014<- F_suii(train_new,2014,"Ｊ１",F)

kensyo_J2_2012<- F_suii(train_new,2012,"Ｊ２",F)
kensyo_J2_2013<- F_suii(train_new,2013,"Ｊ２",F)
kensyo_train_J2_2014<- F_suii(train_new,2014,"Ｊ２",F)

kensyo_test_J1_2014<- F_suii(test_new,2014,"Ｊ１",F)
kensyo_test_J2_2014<- F_suii(test_new,2014,"Ｊ２",F)

#train test 2014all
all <- dplyr::bind_rows(train_new, test_new)
suii_J1_2014<- F_suii(all,2014,"Ｊ１",T)
suii_J2_2014<- F_suii(all,2014,"Ｊ２",T)

kensyo_J1_2014<- F_suii(all,2014,"Ｊ１",F)
kensyo_J2_2014<- F_suii(all,2014,"Ｊ２",F)




write.table(suii_J1_2012, file="C:/study/JLeague/submit/suii_J1_2012.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_J1_2013, file="C:/study/JLeague/submit/suii_J1_2013.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_train_J1_2014, file="C:/study/JLeague/submit/suii_train_J1_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_J2_2012, file="C:/study/JLeague/submit/suii_J2_2012.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_J2_2013, file="C:/study/JLeague/submit/suii_J2_2013.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_train_J2_2014, file="C:/study/JLeague/submit/suii_train_J2_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)

write.table(suii_test_J1_2014, file="C:/study/JLeague/submit/suii_test_J1_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_test_J2_2014, file="C:/study/JLeague/submit/suii_test_J2_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)

write.table(kensyo_J1_2012, file="C:/study/JLeague/submit/kensyo_J1_2012.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_J1_2013, file="C:/study/JLeague/submit/kensyo_J1_2013.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_train_J1_2014, file="C:/study/JLeague/submit/kensyo_train_J1_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_J2_2012, file="C:/study/JLeague/submit/kensyo_J2_2012.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_J2_2013, file="C:/study/JLeague/submit/kensyo_J2_2013.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_train_J2_2014, file="C:/study/JLeague/submit/kensyo_train_J2_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)

write.table(kensyo_test_J1_2014, file="C:/study/JLeague/submit/kensyo_test_J1_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_test_J2_2014, file="C:/study/JLeague/submit/kensyo_test_J2_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)

write.table(suii_J1_2014, file="C:/study/JLeague/submit/suii_J1_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(suii_J2_2014, file="C:/study/JLeague/submit/suii_J2_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_J1_2014, file="C:/study/JLeague/submit/kensyo_J1_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)
write.table(kensyo_J2_2014, file="C:/study/JLeague/submit/kensyo_J2_2014.csv",
            quote=FALSE, sep=",", row.names=F, col.names=T)

#推移表作成
F_suii<- function(df, df_year, df_stage, flag ) {
  J1_2012<- df %>%
    dplyr::filter(year==df_year & stage==df_stage) %>%
    dplyr::select(year,stage,setu,home,away,home_katiten,away_katiten)
  
  #home抽出
  J1_2012_h<- df %>%
    dplyr::filter(year==df_year & stage==df_stage) %>%
    dplyr::select(year,stage,setu,home,home_katiten)
  
  
  #away抽出
  J1_2012_a<- df %>%
    dplyr::filter(year==df_year & stage==df_stage) %>%
    dplyr::select(year,stage,setu,away,away_katiten)
  
  #名前変更
  names(J1_2012_h)[4:5]<-c("team","katiten")
  names(J1_2012_a)[4:5]<-c("team","katiten")
  
  #homeaway関係なく縦に結合
  J1_2012_all <- dplyr::bind_rows(J1_2012_h,J1_2012_a) %>%
    dplyr::arrange(setu) %>%dplyr::arrange(team)
  
  if(!flag){
    return(J1_2012_all)
  }
  
  #数表元データ作成
  J1_2012_suii <-dplyr::distinct(J1_2012, home, .keep_all = T)
  J1_2012_suii <-dplyr::select(J1_2012_suii,-away,-setu,-home_katiten,-away_katiten)
  
  #名前変更
  names(J1_2012_suii)[3]<-c("team")
  
  #推移表に項目追加
  for (i in min(J1_2012$setu):max(J1_2012$setu)) {
    setu_i <- paste("setu_",i,sep="")
    J1_2012_suii <-dplyr::mutate(J1_2012_suii,!!setu_i := 0)
  }
  
  x<-0
  #勝ち点を推移表に反映
  for (i in 1:nrow(J1_2012_all)) {
    #勝ち点表のチームが推移表の何行目か習得
    hi<-grep(J1_2012_all$team[i], J1_2012_suii$team)
    
    x<-J1_2012_all$setu[i]-(min(J1_2012_all$setu)-1)
    
    #推移表のsetu_に勝ち点を加算
    if(is.numeric(J1_2012_suii[hi,3+x-1])){
      J1_2012_suii[hi,3+x]<-J1_2012_suii[hi,3+x-1] + J1_2012_all$katiten[i]
    }else{
      J1_2012_suii[hi,3+x]<-J1_2012_all$katiten[i]
    }
  }
  
  setusuu <- 0
  #推移表に項目追加
  setusuu <- max(J1_2012$setu)-(min(J1_2012$setu)-1)
  
  for (i in min(J1_2012$setu):max(J1_2012$setu)) {
    lank_i <- paste("lank_",i,sep="")
    J1_2012_suii <- dplyr::mutate(J1_2012_suii,!!lank_i := 0)
  }
  for (i in 1:setusuu) {
    J1_2012_suii[3+setusuu+i] <- min_rank(desc(J1_2012_suii[3+i]))
  }
  
  return(J1_2012_suii)
}


