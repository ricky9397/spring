<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>Community</title>


<%@ include file="/WEB-INF/views/frame/metaheader.jsp"%>

<link
	href="${pageContext.request.contextPath}/css/community/community.css"
	rel="stylesheet" />


</head>

<c:url var="getBoardList" value="/community/boardList/">
	<c:param name="page" value="${pagination.page}" />
	<c:param name="range" value="${pagination.range}" />

</c:url>


<body>
	<!-- header -->
	<%@ include file="/WEB-INF/views/frame/header.jsp"%>

	<!-- Contents -->
	<div class="contents_main">
		<div class="contents">
			<h1 style="margin-bottom: 5%;" class="title">
				<a style="" href="<c:url value="/community/boardList"/>">MY
					COMMUNITY</a>
			</h1>



			<!-- 게시판 출력 영역 -->
			<div class="card_main">
				<c:forEach items="${boardList}" var="list">
					<div class="card">
						<div class="board_sidebar">
							<img class="profile_image" img
								src="<c:url value="/images/icon/profile2.png"/>" alt="img">
							<div class="nickname">${list.postnick}</div>

						</div>
						<div class="board_main">
							<button class="title_btn" type="button" onclick="">${list.boardcategory}</button>
							<h2 class="board_title">
								<a
									href="<c:url value="/community/postContent?postidx=${list.postidx}"/>">${list.postname}</a>
							</h2>
							<div class="board_post">${list.postcontent}</div>
							<%--날짜, 조회수--%>
							<div class="board_bottom">
								<div class="write_date">

									<li><img class="left_board_icon"img src="<c:url value="/images/icon/time.png"/>"
											 alt="img">
											<c:set var="date" value="${list.postdate}"/>
											<c:set var="onlydate" value="${fn:substring(date, 0, 16)}" />
											${onlydate}
								</div>
								<ul class="board_btn">

									<li><a href="#"> <img class="board_icon" img
											src="<c:url value="/images/icon/heart.png"/>" alt="img">2
									</a></li>
									<li><a href="#"><img class="board_icon" img
											src="<c:url value="/images/icon/speech-bubble.png"/>"
											alt="img">15</a></li>
								</ul>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- /게시판 출력 영역 -->


			<%--pagination--%>
			<nav aria-label="Page navigation example">
				<ul class="pagination pagination-sm justify-content-center">

					<c:if test="${pagination.prev}">
						<li class="page-item"><a class="page-link" href="#"
							onclick="fn_prev('${pagination.page}','${pagination.range}','${pagination.range}','${pagination.rangeSize}')">
								<span>&laquo;</span>
						</a></li>
					</c:if>

					<c:forEach begin="${pagination.startPage}"
						end="${pagination.endPage}" var="idx">
						</li>
						<li
							class="page-item
            <c:out value="${pagination.page == idx ? 'active' :''}"/> ">
							<a class="page-link" href="#"
							onclick="fn_pagination('${idx}','${pagination.range}','${pagination.rangeSize}')">${idx}</a>
						</li>
					</c:forEach>

					<c:if test="${pagination.next}">
						<li class="page-item"><a class="page-link" href="#"
							onclick="fn_next('${pagination.range}','${pagination.range}','${pagination.rangeSize}')">
								<span>&raquo;</span>
						</a></li>
					</c:if>
				</ul>
			</nav>
			<%-- /pagination--%>
		</div>

	</div>


	<!-- Contents end -->


	<script>

    // 글쓰기 로그인 검사
    function test() {

        if (${loginSession == null}) {
            alert('로그인이 필요합니다.');
            $(location).attr('href', '<c:url value="/member/login"/>');
        } else {
            $(location).attr('href', '<c:url value="/community/write"/>');
        }
    };


    // 게시판 Nav 출력
    $("#comuni").click(function () {
        $.ajax({
            url: "<c:url value='/community/communication'/>",
            type: "get",
            dataType: "json",
            success: function (e) {
                console.log(e);
                $.each(e, function (index, key) {
                    $('.card .nickname').html(key.postnick);
                });
            }
        });
    });


    // 페이징 처리
    // 이전 버튼 이벤트
    function fn_prev(page, range, rangeSize) {
        var page = ((range - 2) * rangeSize) + 1;
        var range = range - 1;

        var url = "${pageContext.request.contextPath}/mypage/mycommunity";
        url = url + "?page=" + page;
        url = url + "&range=" + range;

        location.href = url;
    }

    //페이지 번호 클릭
    function fn_pagination(page, range, rangeSize, searchType, keyword) {
        var url = "${pageContext.request.contextPath}/mypage/mycommunity";
        url = url + "?page=" + page;
        url = url + "&range=" + range;

        location.href = url;
    }

    //다음 버튼 이벤트
    function fn_next(page, range, rangeSize) {
        var page = parseInt((range * rangeSize)) + 1;
        var range = parseInt(range) + 1;

        var url = "${pageContext.request.contextPath}/mypage/mycommunity";
        url = url + "?page=" + page;
        url = url + "&range=" + range;

        location.href = url;
    }

    // 조회수
    function fn_contentView(bid){

        var url = "${pageContext.request.contextPath}/community/";

        url = url + "?bid="+bid;

        location.href = url;

    }


</script>

	<!-- footer -->
	<%@ include file="/WEB-INF/views/frame/footer.jsp"%>