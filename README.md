

# ITFARM

## 목차

1. [프로젝트 개요](#1-프로젝트-개요)
2. [개발인원 및 기간](#2-개발-인원-및-기간)
3. [구현 목적](#3-구현-목적)
4. [개발 환경](#4-개발-환경)
5. [주요기능 및 사이트맵](#5-주요기능-및-사이트맵)
6. [역할 및 담당](#6-역할-및-담당)
7. [프로젝트 설계](#7-프로젝트-설계)
8. [프로젝트 주요기능](#8-프로젝트-주요기능)
9. [문제점 및 개선사항](#문제점-및-개선사항)
10. [성과](#성과)



## 1. 프로젝트 개요

`공공데이터 Open API`를 활용한 `체험 예약` & `상품 구매` 서비스

[top ▲](#itfarm)



## 2. 개발 인원 및 기간

- 개발인원: 4명
- 개발기간: 2018.03 ~ 2018.11 (8개월)

[top ▲](#itfarm)



## 3. 구현 목적

- 사용자는 편리하게 스마트팜 기기를 장바구니에 담아 `구매`
- 국가에서 제공하는 신뢰성 있는 공공데이터를 이용해 `농촌 체험을 예약`
- ‘ITFARM’은 농촌 체험 컨텐츠를 통해 `농촌 관심도 향상`의 기대효과를 얻을 수 있음

[top ▲](#itfarm)



## 4. 개발 환경

- OS : `window 10`
- Language : `JAVA`, `JavaScript`
- DataBase : `MySQL`
- api: `주소`, `결제`, `공공데이터`
- Library/Framework: `구글차트`, `jQuery`, `부트스트랩`

[top ▲](#itfarm)



## 5. 주요기능 및 사이트맵

### 5.1 주요기능

1. 체험예약
2. 상품구매
3. 관리자



### 5.2 사이트맵

- **사용자**

![image-20200221212408721](document/image-20200221212408721.png)

- **관리자**

![image-20200221212420239](document/image-20200221212420239.png)

[top ▲](#itfarm)



## 6. 역할 및 담당

- 사용자페이지(체험예약, 상품구매, 로그인/회원가입, 마이페이지, 장바구니)
- 관리자페이지 (회원관리, 제품관리, 주문관리, 체험관리, 예약관리, 통계)

[top ▲](#itfarm)



## 7. 프로젝트 설계

### 7.1 프로젝트 추진 과정

| 내용/일정         | 세부내용                                               |
| ----------------- | ------------------------------------------------------ |
| **프로젝트 계획** | 스마트팜과 농촌체험에 대한 전망성과 현재시장 수요 조사 |
|                   | 요구사항 수집 및 분석                                  |
|                   | 서비스 대상 선정 (페르소나, 타킷)                      |
|                   | 프로젝트 시나리오 작성                                 |
|                   | 벤치마킹 선정 및 차별성                                |
|                   | 핵심업무 작성 (IA)                                     |
|                   | 업무 흐름도 작성 (Usecase diagram)                     |
|                   | 스토리보드 작성 (UI)                                   |
| **설계**          | IA와 스토리보드를 참고하여 사이트 설계 및 디자인       |
|                   | 시스템 구성도 (System architecture) 작성               |
|                   | Data modeling (ERD) 데이터베이스 설계                  |
| **구현**          | 화면 구현                                              |
|                   | 기능 구현 (사용자, 관리자)                             |
| **유지보수**      | 기능 테스트                                            |
|                   | 캡스톤 디자인 최종 보고서 작성                         |



### 7.2 ERD

- `erwin`으로 작성

![image-20200221213915120](document/image-20200221213915120.png)



### 7.3 스토리보드

- `카카오 오븐`을 이용하여 제작 
- <a href="https://ovenapp.io/view/0Sl5Egj9oruJx4mfBCoMJpHgFIQE4fD0/daNds" target="_blank">스토리보드 테스트 가능한 링크</a>



![[ITFARM] main](document/storyboard.png)



### 7.4 DFD (일부)

![image-20200221225633957](document/image-20200221225633957.png)

![image-20200221230438329](document/image-20200221230438329.png)



#### 7.5 UML

- `StarUML` 로 작성

![image-20200221225729481](document/image-20200221225729481.png)

[top ▲](#itfarm)



## 8. 프로젝트 주요기능

### 8.1 사용자

1. ###### 체험예약

   ![ex_list](document/capture/ex_list.png)

   - `공공데이터`를 활용하여 `체험 예약 서비스`를 `제공`

   

   ![ex_detail](document/capture/ex_detail.png)

   - 날짜 및 인원 선택을 통해 예약 진행

   

   <img src="document/capture/ex_pay1.png" alt="ex_pay1" style="zoom:67%;" />

   <img src="document/capture/ex_pay2.png" alt="ex_pay2" style="zoom:67%;" />

   - 결제 페이지에서 `원하는 수단 선택` 후 `결제 진행`

   

   ![ex_pay3](document/capture/ex_pay3.png)

   - `결제 api`를 통해 결제 진행

   

   ![ex_pay4](document/capture/ex_pay4.png)

   ![ex_pay5](document/capture/ex_pay5.png)

   - 예약된 내역 확인 가능

   - 날짜가 지난 예약은 취소 불가 처리

     

2. ###### 상품구매

   ![product_detail](document/capture/product_detail.png)

   - 상세페이지에서 수량 확인 후 구매 진행

   

   ![product_cart](document/capture/product_cart.png)

   - 장바구니에 담은 상품 구매 가능

   

   ![product_buy](document/capture/product_buy.png)

   - 체험 예약과 마찬가지로 `카드 결제`와 `휴대폰 결제` 진행 가능

   

   ![product_buy2](document/capture/product_buy2.png)

   - 마이페이지에서 구매내역 확인

   

3. ###### 멤버십 관련 기능

   ![product_buy3](document/capture/product_buy3.png)

   - 내 활동과 관련된 내역 확인 가능



### 8.2 관리자

1. ###### 메인

   ![admin_main](document/capture/admin_main.png)

   - 사이트 관련 현황을 확인 가능

     

2. ###### 회원관리

   ![admin_member](document/capture/admin_member.png)

   - 회원 정보를 확인하고 강제 탈퇴 가능

   - 탈퇴된 회원은 개인정보를 지우고 아이디만 컬럼에 저장

     

3. ###### 상품관리

   ![admin_product](document/capture/admin_product.png)

   - 주문에 관련된 검색 조건 선택 후 검색 가능

   - 주문 상태에 따라 무통장 입금 확인, 운송장 등록, 반품 승인/거절 처리 가능

     

   ![admin_product_reg](document/capture/admin_product_reg.png)

   - 제품 관리 메뉴에서는 제품을 등록하고 수정 가능

   - 상세 설명 부분은 관리자가 작성한대로 줄바꿈을 처리

     

4. ###### 예약관리

   ![admin_ex](document/capture/admin_ex.png)

   - 예약과 관련된 내용을 확인, 검색 가능

     

5. ###### 통계

   ![admin_sta_pro](document/capture/admin_sta_pro.png)

   - 상품, 체험, 예약, 주문, 회원 통계를 확인 가능한 메뉴

   - 월별, 주별, 일별 통계를 확인 가능

   - `구글 차트` 라이브러리를 사용

     

   ![admin_sta_pro2](document/capture/admin_sta_pro2.png)

   - 매출 내역을 표 형태로 확인 가능

   - 전주 대비 금주 매출 상승률 확인 가능

     

   ![admin_sta_ex](document/capture/admin_sta_ex.png)

   - 매출 Top 10 상품 확인 가능

     

### 기타

1. ###### 에러 페이지 처리

![error](document/capture/error.png)



[top ▲](#itfarm)



## 문제점 및 개선사항

- 로그인, 회원가입 시 보안 처리 안됨

- 트랜잭션 처리 없음

- 커넥션 풀 고려하지 못한 개발
- 비동기 처리가 필요한 부분에 적용하지 못함

[top ▲](#itfarm)



## 배운 점

- 졸업작품전 장려상

- 기획, 설계부터 개발까지 전과정 경험


[top ▲](#itfarm)