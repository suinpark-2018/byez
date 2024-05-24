<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>[BYEZ] 회원가입 본인인증</title>
</head>

<link rel="stylesheet" href="/css/requestEmailForm.css">

<body>
<div class="logo-wrapper">
    <a href="/">
        <img src="/img/byez.png" alt="메인로고" class="main-logo">
    </a>
</div>
<section class="wrapper">
    <header class="header">
        BYEZ 회원가입
    </header>

    <header class="sub-header">
        <h2>본인 확인</h2>
        <h3>이메일 인증 단계</h3>
        <h4>인증번호를 받을 이메일을 입력해주세요.</h4>
    </header>

    <div class="verify-email">
        <div class="send-email">
            E-mail: <input type="email" id="email" name="email" oninput="checkEmailFormat(this.value)" placeholder="byez@example.com" required>
            <button id="sendEmailBtn" disabled>전송</button>
        </div>
        <div id="email-format-error-msg"></div>

        <%-- 이메일 전송 후 보여주기 --%>
        <div class="input-verification-code" id="verificationDiv" onclick="showVerifyEmailForm()">
            <h4>인증번호를 받지 못하셨다면, 다시 전송 버튼을 클릭하십시오.</h4>
            인증 번호: <input type="text" id="verificationCode" name="mail_key" required>
            <button id="verifyCodeBtn">인증</button>
        </div>
    </div>
</section>
</body>

<script>
    function showVerifyEmailForm() {
        let verificationCodeInput = document.getElementById("verificationDiv");
        verificationCodeInput.style.display = "block"; // 인증번호 입력란 보이도록 변경
    }

    function checkEmailFormat(inputValue) {
        let emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$/i;
        let sendEmailBtn = document.getElementById("sendEmailBtn");
        let msg = document.getElementById("email-format-error-msg");

        if (inputValue.length > 0 && !emailPattern.test(inputValue)) {
            msg.innerHTML = "잘못된 이메일 형식입니다.";
            sendEmailBtn.disabled = true;
        } else {
            msg.innerHTML = ""
            sendEmailBtn.disabled = false;
        }
    }
</script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

    // 1. '인증번호 전송' 버튼 클릭
    $(document).ready(function() {
        $("#sendEmailBtn").click(function() {
           let email = $("#email").val();

            $.ajax({
                url: "/register/send",
                type: "POST",
                data: { email: email },
                success: function (response) {
                    $("#verificationDiv").show();
                    alert("인증번호 전송 성공")
                },
                error: function (xhr, status, error) {
                    console.error("메일 전송 실패:", error);
                    alert(xhr.responseText);
                }
            });
        });

        // 2. '인증하기' 버튼 클릭
        $("#verifyCodeBtn").click(function() {
            let verificationCode = $("input[name='mail_key']").val();
            console.log($("input[name='mail_key']").val());
            $.ajax({
                url: "/register/verifyEmail",
                type: "POST",
                data: { verificationCode: verificationCode },
                success: function(response) {
                    alert("본인인증 완료");
                    window.location.href = "/register/form";
                },
                error: function(xhr, status, error) {
                    console.error("인증 실패: ", error);
                    alert(xhr.responseText);
                }
            });
        });
    });

</script>

</html>