# MarisolBoard
스프링 프레임워크를 이용한 회원제 게시판

## 목차

### 1. [프로젝트 개요](#1-ed9484eba19ceca09ded8ab8-eab09cec9a94-1)
### 2. [프로젝트 문서](#2-ed9484eba19ceca09ded8ab8-ebacb8ec849c-1)
### 3. [주요 기능 및 구현 화면](#3-eca3bcec9a94-eab8b0eb8aa5-ebb08f-eab5aced9884-ed9994eba9b4-1)

## 1. 프로젝트 개요

### 🎯 목표

인트라넷 (파일을 첨부하여 게시글을 작성할 수 있는 회원제 게시판) 개발

- **프로젝트 목표**: SpringFramework를 이용한 애플리케이션 개발에 대한 이해향상 및 기술 습득
- **프로젝트 수행 기간**: 2023년 04월 24일~2023년 05월 26일 ( 약 1개월 ) + 추가 1주일
<br>
<br>

### ⚒️ 기술 스택

[![Spring Framework](https://img.shields.io/badge/Spring_Framework-6DB33F?style=for-the-badge&logo=spring&logoColor=white)](https://spring.io/)
[![MyBatis](https://img.shields.io/badge/MyBatis-3399FF?style=for-the-badge&logo=mybatis&logoColor=white)](https://mybatis.org/)
[![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)](https://mariadb.org/)
[![Apache Tomcat](https://img.shields.io/badge/Apache_Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)
[![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)](https://maven.apache.org/)
[![Eclipse IDE](https://img.shields.io/badge/Eclipse_IDE-2C2255?style=for-the-badge&logo=eclipse-ide&logoColor=white)](https://www.eclipse.org/)
[![AWS EC2](https://img.shields.io/badge/AWS_EC2-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/ec2/)
[![AWS RDS](https://img.shields.io/badge/AWS_RDS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/rds/)
[![HTML](https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/HTML)
[![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![CSS](https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/CSS)
[![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=jsp&logoColor=white)](https://www.oracle.com/java/technologies/jspt.html)

### 🚀 개발 및 배포 환경
![아키텍쳐](images/architecture.png)

## 2. 프로젝트 문서

### 📝 요구사항 정의 및 페이지·기능 명세서

![요구사항 정의 및 페이지·기능 명세서](images/documents/functional_specification.png)

### 📝 테이블 명세서 및 ERD

![테이블 명세서](images/documents/table_specifications.png)
![ERD](images/documents/erd.png)

## 3. 주요 기능 및 구현 화면

### 🪪 회원 기능
  - 회원가입
    ![회원가입](images/ImplementationScreens/signup.png)

    <center>
    
    | 기능 |   | 부기능  |   |
    |-------|-------|-------|-------|
    | 1 | 프로필 사진 추가 | 1 | 우편번호 검색 |
    | 2 | 회원가입 처리 | 2 | 입력정보 피드백 제공 |

    <center>
    <br><br>

  - 로그인
    ![로그인](images/ImplementationScreens/login.png)
    
    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 로그인 | 1 | 회원가입 화면 |
    | 2 | 아이디·비밀번호 저장 | 2 | 아이디·비밀번호 찾기 화면 |
    | 3 | 자동 로그인 |  |  |

    <center>
    <br><br>

  - 비밀번호 변경 주기 알림
    ![비밀번호 변경 주기 알림](images/ImplementationScreens/pw_warn.png)
    
    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 비밀번호 변경 주기 30일 연장 | 1 | 비밀번호 변경 화면 |
    | 2 | 다음 로그인 시 알리도록 설정 |  |  |

    <center>
    <br><br>

  - 아이디 찾기
    ![아이디 · 비밀번호 찾기](images/ImplementationScreens/find_idpw.png)
    
    <center>
    
    | 기능    | |
    |---------|-|
    | 1 | 아이디 찾기  |
    | 2 | 비밀번호 찾기 - 임시비밀번호 발급  |

    <center>

    - 이메일로 임시 비밀번호가 발급된 화면
    ![임시 비밀번호 발급된 화면](images/ImplementationScreens/temp_pw.png)
  
  - 회원 정보수정 및 비밀번호 변경
    ![회원 정보수정 및 비밀번호 변경](images/ImplementationScreens/my_page.png)

    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 가입 시 입력 정보 조회 및 수정 | 1 | 비밀번호 변경 화면 |
    | 2 | 정보 수정 처리 |  |  |
    | 3 | 최근 비밀번호 설정 일자 확인|  |  |

    <center>
    <br><br>

### 📋 게시판 기능
  - 글 목록
    ![글 목록](images/ImplementationScreens/list.png)

    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 전체 게시글 목록 조회 | 1 | 게시글 상세 보기 화면 |
    | 2 | 검색 결과 게시글 목록 조회 | 2 | 글쓰기 화면 |
    | 3 | 페이지 이동 | 3 | 마이페이지 화면 |
    | 4 | 로그아웃 처리 | 4 | (관리자만) 관리자 메뉴 화면 |

    <center>
    <br><br>

  - 글 쓰기
    ![글 쓰기](images/ImplementationScreens/write.png)

    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 글 (제목·내용)작성 | 1 | 글 등록 취소 - 이전 화면 |
    | 2 | 파일 첨부 |  |  |
    | 3 | 글 등록 처리 |  |  |

    <center>
    <br><br>

  - 글 상세보기
    ![글 상세보기](images/ImplementationScreens/view.png)

    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 글 내용·첨부파일조회 | 1 | (작성자만) 글 수정 화면 |
    | 2 | 첨부파일 다운로드 | 2 | 이전·다음 글 상세 보기 화면 |
    | 3 | 좋아요·싫어요 평가 | 3 | 목록 화면 |
    | 4 | 댓글 조회·등록·수정·삭제 |  |  |
    | 5 | (작성자만) 게시 글 삭제 |  |  |

    <center>
    <br><br>

  - 글 수정
    ![글 수정](images/ImplementationScreens/modify.png)

    <center>
    
    | 기능 |   | 링크  |   |
    |-------|-------|-------|-------|
    | 1 | 글 내용·첨부파일조회 | 1 | 수정 취소 - 글 상세보기 화면 |
    | 2 | 글 제목·내용 수정 |  |  |
    | 3 | 첨부파일 삭제 |  |  |
    | 4 | 새 첨부파일 등록 |  |  |
    | 5 | 수정 사항 등록 |  |  |

    <center>
    <br><br>

### 🧑‍🔧 관리자 기능
  - ![관리자 메뉴](images/ImplementationScreens/manager.png)

    <center>
    
    | 기능 |   | 
    |-------|-------|
    | 1 | 관리자 메뉴 조회 |
    | 2 | 시스템 정보 조회 |
    | 3 | 첨부 파일 관리 (삭제) |

    <center>
    <br><br>
