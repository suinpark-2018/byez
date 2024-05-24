<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BYEZ</title>
    <link rel="stylesheet" href="/css/nav.css?after">
    <link rel="stylesheet" href="/css/like.css?after?after?after?after">
    <link rel="stylesheet" href="/css/footer.css">
    <link rel="stylesheet" href="/css/quick.css">
    <script src="https://kit.fontawesome.com/f0e73cfa04.js" crossorigin="anonymous"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
</head>
<body>
<%@include file="../views/include/nav.jsp"%>

<section>
    <div class="wrapper">
        <div class="title">
            <p>
                <a href="main.html"><span>home</span></a>
                <span>></span>
                <a href="like.html"><span>위시리스트</span></a>
            </p>
            <p>위시 리스트</p>
        </div>

        <jsp:include page="/WEB-INF/views/include/aside.jsp"/>

        <hr>
        <div class="content">
            <ul class="wishList">
                <c:forEach var="likeItemDto" items="${list}">
                <li class = "likeItemInfo">
                    <a href="/goods/${likeItemDto.num}">
                        <div style="background-image: url(${likeItemDto.main_img});">
                        </div>
                    </a>
                    <ul class="itemInfo">
                        <li class="itemName">${likeItemDto.name}</li>
                        <li>
                            <del class="sales_price"><fmt:formatNumber value="${likeItemDto.price}" pattern="#,###"/>원</del>
                            <span class="sales_price"><fmt:formatNumber value="${likeItemDto.disc_price}" pattern="#,###"/>원</span>
                            <em class="textStyle">30%</em>
                        </li>
                        <li class="textStyle">
                            <i class="fa-solid fa-heart"></i>
                            <span>${likeItemDto.like_cnt}</span>
                        </li>
                        <li>리뷰수 : ${likeItemDto.review_cnt}</li>
                    </ul>
                    <input type="checkbox" class ="checkBox" data-id="${likeItemDto.id}" data-num="${likeItemDto.num}">
                </li>
                </c:forEach>
            </ul>
            <!-- 버튼 및 페이징 -->
            <div class="btnPaging">
                <!-- 이전 페이지 버튼 -->
                <c:if test="${ph.showPrev}">
                    <a href="<c:url value='/like${ph.getQueryString(ph.beginPage-1)}' />">&lt;</a>
                </c:if>

                <!-- 네비 숫자 -->
                <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                    <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/like${type}${ph.getQueryString(i)}"/>">${i}</a>
                </c:forEach>

                <!-- 이후 페이지 버튼 -->
                <c:if test="${ph.showNext}">
                    <a href="<c:url value='/like${type}${ph.getQueryString(ph.endPage+1)}' />">&gt;</a>
                </c:if>
            </div>
            <button class="modifyBtn">편집</button>
            <button class="btnStyle deleteBtn" style="display: none">삭제</button>
            <button class="btnStyle cancelBtn" style="display: none">취소</button>
        </div>
        <hr>
    </div>

    <form action="/like/add" method="post" class="addLikeForm">

    </form>

    <%--            <button class="modifyLikeBtn">변경</button>--%>
    <form action="/like/modify" method="post" class="modifyLikeForm">

    </form>

    <%--            <button class="removeLikeBtn">삭제</button>--%>
    <form action="/like/remove/several" method="get" class="removeSeveralLikeForm">
    </form>

    <form action="/like/remove" method="get" class="removeLikeForm">
    </form>
</section>
<%@include file="../views/include/quick.jsp"%>
<%@include file="../views/include/footer.jsp"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="/js/nav.js?after"></script>
<script src="/js/like.js"></script>
</body>
</html>