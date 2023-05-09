# dplyr 패키지 설치 및 로드하기(p.207)
install.packages("dplyr")
library(dplyr)


# mtcars 데이터 세트 구조 확인하기(p.208)
nrow(mtcars)
str(mtcars)


# 조건에 맞는 데이터 추출하기(p.209)
filter(mtcars, cyl == 4)


# 두 가지 조건에 맞는 데이터를 필터링하기(p.209)
filter(mtcars, cyl >= 6 & mpg > 20)


# 지정한 변수만 추출하기(p.210)
head(select(mtcars, am, gear))


# 오름차순 정렬하기(p.211)
head(arrange(mtcars, wt))


# 오름차순 정렬한 후 내림차순 정렬하기(p.212)
head(arrange(mtcars, mpg, desc(wt)))


# 새로운 열 추가하기(p.213)
head(mutate(mtcars, years = "1974"))

head(mutate(mtcars, mpg_rank = rank(mpg)))


# 중복 값 제거하기(p.214)
distinct(mtcars, cyl)

distinct(mtcars, gear)


# 여러 개 열에서 중복 값 제거하기(p.215)
distinct(mtcars, cyl, gear)


# 데이터 요약하기(p.216)
summarise(mtcars, cyl_mean = mean(cyl), cyl_min = min(cyl), cyl_max = max(cyl))

summarise(mtcars, mean(cyl), min(cyl), max(cyl))


# 그룹별로 요약하기(p.217)
gr_cyl <- group_by(mtcars, cyl)
summarise(gr_cyl, n())

gr_cyl <- group_by(mtcars, cyl)
summarise(gr_cyl, n_distinct(gear))


# 샘플 데이터 10개 추출하기(p.218)
sample_n(mtcars, 10)


# 전체 데이터의 20%를 샘플로 추출하기(p.219)
sample_frac(mtcars, 0.2)


# 파이프 연산자로 그룹별 요약하기(p.220)
group_by(mtcars, cyl) %>% summarise(n())


# 파이프 연산자 없이 순위 기준으로 정렬하기(p.220)
mp_rank <- mutate(mtcars, mpg_rank = rank(mpg))
arrange(mp_rank, mpg_rank)


# 파이프 연산자를 사용하여 순위 기준으로 정렬하기(p.221)
mutate(mtcars, mpg_rank = rank(mpg)) %>% arrange(mpg_rank)

library(dplyr)

library(readxl)
exdata1 <- read_excel("C:/Rstudy/Sample1.xlsx")
exdata1


# 선택한 변수 추출하기(p.226)
exdata1 %>% select(ID)


# 선택한 변수 여러 개 추출하기(p.226)
exdata1 %>% select(ID, AREA, Y21_CNT)


# 선택한 변수 제외하고 추출하기(p.227)
exdata1 %>% select(-AREA)

exdata1 %>% select(-AREA, - Y21_CNT)


# 조건에 만족하는 데이터만 추출하기(p.229)
exdata1 %>% filter(AREA == '서울')

exdata1 %>% filter(AREA == '서울' & Y21_CNT >= 10)


# 오름차순 정렬하기(p.230)
exdata1 %>% arrange(AGE)


# 내림차순 정렬하기(p.231)
exdata1 %>% arrange(desc(Y21_AMT))


# 중첩 정렬하기(p.232)
exdata1 %>% arrange(AGE, desc(Y21_AMT))


# 변수 값 합산하기(p.233)
exdata1 %>% summarise(TOT_Y21_AMT = sum(Y21_AMT))


# 변수 값을 그룹별로 합산하기(p.233)
exdata1 %>% group_by(AREA) %>% summarise(SUM_Y21_AMT = sum(Y21_AMT))


# 엑셀 파일 불러오기(p.235)
library(readxl)
m_history <- read_excel("C:/Rstudy/Sample2_m_history.xlsx")
f_history <- read_excel("C:/Rstudy/Sample3_f_history.xlsx")
View(m_history)
View(f_history)


# 테이블을 세로로 결합하기(p.236)
exdata_bindjoin <- bind_rows(m_history, f_history)
View(exdata_bindjoin)


# 엑셀 파일 불러오기(p.237)
library(readxl)
jeju_y21_history <- read_excel("C:/Rstudy/Sample4_y21_history.xlsx")
jeju_y20_history <- read_excel("C:/Rstudy/Sample5_y20_history.xlsx")
View(jeju_y21_history)
View(jeju_y20_history)


# 첫 번째 테이블 기준으로 가로 결합하기(p.239)
bind_col <- left_join(jeju_y21_history, jeju_y20_history, by = "ID")
View(bind_col)


# 키 변수가 동일할 때만 가로 결합하기(p.240)
bind_col_inner <- inner_join(jeju_y21_history, jeju_y20_history, by = "ID")
View(bind_col_inner)


# 키 변수를 기준으로 모두 가로 결합하기(p.241)
bind_col_full <- full_join(jeju_y21_history, jeju_y20_history, by = "ID")
View(bind_col_full)

# reshape2 패키지 설치하기(p.248)
install.packages("reshape2")


# airquality 데이터 세트 확인하기(p.249)
head(airquality)


# 변수명 소문자로 통일하기(p.249)
names(airquality) <- tolower(names(airquality))
head(airquality)


# 열을 행으로 바꾸기(p.250)
library(reshape2)
melt_test <- melt(airquality)
head(melt_test)

tail(melt_test)


# 기준을 정해 열을 행으로 바꾸기(p.251) 
melt_test2 <- melt(airquality, id.vars = c("month", "wind"),
                   measure.vars = "ozone")
head(melt_test2)


# 변수명 소문자로 통일하기(p.253)
names(airquality) <- tolower(names(airquality))
head(airquality)


# 열을 행으로 바꾸기(p.254)
library(reshape2)
aq_melt <- melt(airquality, id.vars = c("month", "day"), na.rm = FALSE)
head(aq_melt)


# 행을 열로 바꾸기(p.254 ~ p.256)
aq_dcast <- dcast(aq_melt, month + day ~ variable)
head(aq_dcast)

View(airquality)
View(aq_melt)
View(aq_dcast)


# 행을 변수로 바꾸기(p.257)
acast(aq_melt, day ~ month ~ variable)


# cast() 함수로 평균 요약 확인하기(p.258)
acast(aq_melt, month ~ variable, mean)


# cast() 함수로 합계 요약 확인하기(p.258)
dcast(aq_melt, month ~ variable, sum)

# 결측치 확인하기(p.263)
x <- c(1, 2, NA, 4, 5)
x
sum(x)
is.na(x)
table(is.na(x))


# 결측치 제외하고 연산하기(p.264)
x <- c(1, 2, NA, 4, 5)
x
sum(x)
is.na(x)
sum(x, na.rm = T)


# airquality 데이터 세트 결측치 확인하기(p.265)
data(airquality)
is.na(airquality)


# 데이터 세트에 있는 결측치 전체 개수 확인하기(p.266)
sum(is.na(airquality))


# 컬럼별 결측치 개수 확인하기(p.266)
colSums(is.na(airquality))


# 결측치가 있는 행 제거하기(p.266)
data(airquality)
na.omit(airquality)


# 결측치 0으로 대체하기(p.267)
data(airquality)
airquality[is.na(airquality)] <- 0
colSums(is.na(airquality))


# 이상치 확인하기(p.268)
data(mtcars)
boxplot(mtcars$wt)


# 상자 그림의 기술통계량 확인하기(p.269)
boxplot(mtcars$wt)$stats


# 이상치 확인하기(p.270 ~ p.271)
mtcars$wt > 5.25

mtcars$wt <- ifelse(mtcars$wt > 5.25, NA, mtcars$wt)
mtcars$wt
