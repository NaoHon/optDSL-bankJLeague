#�g�p���C�u����
library(randomForest)
library(dplyr)
library(pROC)

#�f�[�^�ǂݍ���
train<-dplyr::select(lm_train_j1, y2, tv_num, capa, setu2, home, kyuutu,address_ken,timeInt_c,gameW,away,year)
test<-lm_test_j1_2
train$y2 <- round(train$y2)
###Hold Out
#�\�z�f�[�^�̊���
rate<-0.7

#�\�z�f�[�^��(�����̐؎̂�)
num<-as.integer(nrow(train)*rate)

#�Č����̂��ߗ����V�[�h���Œ�
set.seed(17)

#sample(�x�N�g��, �����_���Ɏ擾�����, �������o�̗L��)
row<-sample(1:nrow(train), num, replace=FALSE)

#�\�z�f�[�^
rf_train_train<-train[row,] %>%
  dplyr::select( -y2 )

#���؃f�[�^
rf_train_test<-train[-row,] %>%
  dplyr::select( -y2 )

#�ړI�ϐ��쐬
y_train_train<- train[row,] %>%
  dplyr::select(y2)
y_train_test<- train[-row,] %>%
  dplyr::select(y2)

#�Č����̂��ߗ����V�[�h���Œ�
set.seed(17)
tuneRF(y_train_train, as.factor(y_train_train$y),doBest=TRUE)

rf<-randomForest(rf_train_train, #�w�K�f�[�^(�����ϐ�)
                 as.factor(y_train_train$y), #�w�K�f�[�^(�ړI�ϐ�)
                 mtry=4, #1�{�̖؂Ɏg�p����ϐ��̐�
                 sampsize=nrow(rf_train_train)*0.3, #���f���\�z�Ɏg�p����f�[�^��
                 nodesize=30, #��������e����؂̃m�[�h���܂ރT���v���ŏ���
                 maxnodes=5, #��������e����؂̏I�[�m�[�h�̍ő吔
                 ntree=500, #�������錈��؂̐�
                 imprtance=T #�ϐ��d�v�x�̗L��
)

##train_test��AUC
#prediction(�\������,�ړI�ϐ�(1 or 0))
pred <-predict(rf, newdata=rf_train_test, type="prob")[,2]
auc<-roc(y_train_test$y2, pred)
print(auc)

##�ϐ��d�v�x
print(importance(rf))