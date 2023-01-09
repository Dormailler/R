# 2021년 사망 교통사고 정보
library(ggmap)
register_google(key='AIzaSyCxJq8tlDIj8KiNayhBNrA2R_AkGjamNpE')    # 구글키 등록
library(ggplot2)

setwd("C:\\Users\\gerre\\Desktop")                                # 작업 폴더 지정
df <-  read.csv('Daejeon.csv')                                    # .csv 파일 읽기(대전 교통사고 정보)
cen <- geocode(enc2utf8("대전광역시")) 		                        # 지점의 경도 위도
cen <- as.numeric(cen)                                            # 경도 위도를 숫자로
gc <- data.frame(df$x,df$y)                                       # 교통사고 발생 위치 좌표값 데이터
map <- get_googlemap(center = cen,                                # 지도 가져오기
                     maptype = "roadmap",                         # 지도의 유형
                     zoom = 11,                                   # 지도 확대 정도
                     marker=gc)                                   # 마커의 위치
ggmap(map)                                                        # 지도와 마커 화면에 보이기

df1 <- read.csv('Gu.csv')                                         # .csv 파일 읽기(구별 교통사고 정보)
cen1 <-c(mean(df1$lon), mean(df1$lat))                            # 지도의 중심점 계산
map <- get_googlemap(center = cen1,                               # 지도 가져오기
                     maptype = "roadmap",
                     zoom = 11) 
gmap <- ggmap(map)  #지도를 저장
gmap+geom_point(data=df1,                                         # 구별 교통사고 건수를 원의 크기로 표시
                aes(x=lon,y=lat,size=number),
                alpha=1,
                col='black')+geom_text(
                data=df1, 		                                    # 지도 위에 텍스트 표시(교통사고 건수)
                aes(x=lon,y=lat-0.01), 	                          # 텍스트 위치
                size=5, 			                                    # 텍스트 크기
                label=df1$number)+geom_text(                      # 텍스트 내용
                data=df1, 		                                    # 지도 위에 텍스트 표시(해당위치 구이름)
                aes(x=lon,y=lat-0.025), 		                            
                size=7, 			                                          
                label=df1$Gu) 		                                     

df2 <-  read.csv('Yuseong.csv')                                   # .csv 파일 읽기(유성구 교통사고 정보)
cen2 <-c(mean(df2$x), mean(df2$y))                                 
gc <- data.frame(df2$x,df2$y)                                     # 측정위치 좌표값 데이터
map <- get_googlemap(center = cen2,                               # 유성구 교통사고 위치를 표시
                     maptype = "roadmap",
                     zoom = 12,
                     marker=gc)
ggmap(map)                                                        # 지도와 마커 화면애 보이기



