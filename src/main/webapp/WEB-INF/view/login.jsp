<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <style>
    body {
      background-color: #ffe9cc;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .login-buttons {
      display: flex;
      gap: 30px;
    }

    .social-btn {
      width: 80px;
      height: 80px;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      cursor: pointer;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      transition: transform 0.2s;
    }

    .social-btn:hover {
      transform: scale(1.05);
    }

    .kakao {
      background-color: #FEE500;
    }

    .naver {
      background-color: #03C75A;
    }

    .google {
      background-color: white;
      border: 1px solid #ddd;
    }

    .social-icon {
      width: 40px;
      height: 40px;
    }
  </style>
</head>
<body>

  <div class="login-buttons">
    <!-- Kakao -->
    <a href="/oauth2/authorization/kakao" class="social-btn kakao">
      <img src="https://upload.wikimedia.org/wikipedia/commons/e/e3/KakaoTalk_logo.svg" alt="Kakao" class="social-icon" />
    </a>
    
    <!-- Naver -->
    <a href="/oauth2/authorization/naver" class="social-btn naver">
      <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTA5MTVfMTkw%2FMDAxNjMxNjk2MzM4NjYy.afH1qY-8zg4NeCiRF7xkXpXwRRRQ3rhpyphINwDIOSwg.H-lX7EaH3gynXGNyccJk6bTkAd_JsDDMziPbEVtJzcgg.PNG.nd1126%2F20210915_175842.png&type=a340" alt="Naver" class="social-icon" />
    </a>
    
    <!-- Google -->
    <a href="" class="social-btn google">
      <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google" class="social-icon" />
    </a>
  </div>

</body>
</html>
