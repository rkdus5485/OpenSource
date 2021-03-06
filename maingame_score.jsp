
<%@ page language="java" contentType ="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.io.PrintWriter" %>
<%		Class.forName("com.mysql.jdbc.Driver");

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		PreparedStatement ps = null;

		try{
			String jdbcDriver = "jdbc:mysql://webdev.iptime.org:3306/rkdus?"+"useUnicode=true&characterEncoding=utf8";
			String dbUser = "kgy";
			String dbPass = "kgy1234";



			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

			String username = (String)session.getAttribute("username");

			stmt = conn.createStatement();
			String query = "select point from record_withouttimer where GameUsername = '"+ username + "'";
			ps = conn.prepareStatement(query);
			rs=ps.executeQuery();



		if(username == null){
		%>
				<script>
				alert('로그인 되지 않았습니다. 로그인 페이지로 이동합니다.');
				window.location.href="http://webdev.iptime.org:8080/kgy/gamesignin.html";
				</script>
				<%

}
%>


<html lang="en">
 <head>
  <meta charset="UTF-8">
  <title>같은 그림 찾기</title>
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <style type="text/css">
		body{background: #007bff; background: linear-gradient(to right, #0062E6, #33AEFF); text-align: center;}
        .width500px{width: 400px;  display: inline-block; text-align: center;}
        .center{text-align: center;}
        #cardTable{border-collapse: collapse; width:100%}
        #cardTable td{border: 1px solid #42423E; width: 25%; height: 121px; text-align: center; cursor: pointer;}
        #cardTable td img{width: 100%;}
        #cardTable td span{font-size: 25pt; font-weight: bold; color: #42423E; display: none;}
        #countDown{background-color: #42423E; color: white; font-size: 20pt; width: 90%; height: 40px;border-radius: 1rem; float:left;}
	#exit{background-color:red; color: white; font-size: 20pt; width: 10%; border-radius: 1rem;height: 40px; float:left;}
	#username{background-color: #42423E; color: white; font-size: 12pt; width: 33%; border-radius: 1rem; float:left;}
        #info{width: 100%; height: 300px; border-radius: 1rem; background-color: #DDDDDD; color: black; padding-top: 250px;}
	#maxscore{background-color: #42423E; color: white; font-size: 12pt; width: 33%; border-radius: 1rem; float:left}




#startBtn{
  border: 0;
  border-radius: 1rem;
  color: white;
  background-color: #42423E;
  width: 33%;
  font-size: 12pt;
  cursor: pointer;
  border-collapse: collapse;
  display: inline-block;
}

#scoreBtn{
font-size: 20pt;
  border: 0;
  border-radius: 1rem;
  color: white;
  background-color: #42423E;
  width: 100%;
  padding: 5px;
  border-collapse: collapse;
  display: inline-block;

}

.card-signin {
  background: #FFFFFF;
  border: 0;
  border-radius: 1.5rem;
  box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1);
}

.card-signin .card-body {
  padding: 2rem;
}
        </style>


  <script>
	// 게임 상태
            var gameState = '';

            // 열린 카드 src
            var openCardId = '';
            var openCardId2 = '';

            // 난수 생성 함수
            function generateRandom (min, max) {
                var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
                    return ranNum;
            }


            var cards; // 카드 목록
            var score = 0; // 점수
            var openedCtn = 0; // 맞춘 카드 갯수

            // 카드 배치
            function setTable(){
                cards = [
                'https://image.flaticon.com/icons/svg/1728/1728729.svg','https://image.flaticon.com/icons/svg/1728/1728729.svg', // 오렌지
                'https://image.flaticon.com/icons/svg/1868/1868212.svg','https://image.flaticon.com/icons/svg/1868/1868212.svg', // 파인애플
                'https://image.flaticon.com/icons/svg/765/765560.svg','https://image.flaticon.com/icons/svg/765/765560.svg', // 포도
                'https://image.flaticon.com/icons/svg/590/590772.svg','https://image.flaticon.com/icons/svg/590/590772.svg', // 딸기
                'https://image.flaticon.com/icons/svg/415/415733.svg','https://image.flaticon.com/icons/svg/415/415733.svg', // 사과
                'https://image.flaticon.com/icons/svg/1135/1135549.svg','https://image.flaticon.com/icons/svg/1135/1135549.svg', // 바나나
                'https://image.flaticon.com/icons/svg/874/874997.svg','https://image.flaticon.com/icons/svg/874/874997.svg', // 수박
                'https://image.flaticon.com/icons/svg/2754/2754032.svg','https://image.flaticon.com/icons/svg/2754/2754032.svg', // 체리
                'https://image.flaticon.com/icons/svg/700/700804.svg','https://image.flaticon.com/icons/svg/700/700804.svg', // 망고
                'https://image.flaticon.com/icons/svg/2548/2548560.svg','https://image.flaticon.com/icons/svg/2548/2548560.svg', // 메론
                'https://image.flaticon.com/icons/svg/590/590775.svg','https://image.flaticon.com/icons/svg/590/590775.svg' // 복숭아
                ];
                var cardTableCode = '<tr>';
                for(var i=0;i<20;i++) {
                    if(i>0 && i%4 == 0){
                        cardTableCode += '</tr><tr>';
                    }
                    var idx = generateRandom(0,19-i);
                    var img = cards.splice(idx,1);

                    cardTableCode += '<td id="card'+i+'"><img src="'+img+'"><span>?</span></td>';
                }
                cardTableCode += '</tr>';
                $('#cardTable').html(cardTableCode);
            }

            // 카드 전체 가리기
            function hiddenCards(){
                $('#cardTable td img').hide();
                $('#cardTable td span').show();
            }

            // 게임 시작
            function startGame() {
                var sec =6;

                $('#info').hide(); // 안내 문구 가리기
                scoreInit(); // 점수 초기화
                setTable(); // 카드 배치

                //준비 카운트 다운
                function setText(){
                    $('#countDown').text(--sec);
                }

                //시작 카운트 다운
                var intervalID = setInterval(setText, 1000);
                setTimeout(function(){
                    clearInterval(intervalID);
                    $('#countDown').text("시작!");
                    hiddenCards();
                    gameState = 'ingame';
                }, 6000);
            }


            // 카드 선택 시
            $(document).on('click', '#cardTable td', function(){
                if(gameState != 'ingame') return; // 게임 카운트 다운중일 때 누른 경우 return
                if(openCardId2 != '') return; // 2개 열려있는데 또 누른 경우 return
                if($(this).hasClass('opened')) return; // 열려있는 카드를 또 누른 경우
                $(this).addClass('opened'); // 열여있다는 것을 구분하기 위한 class 추가

                if(openCardId == '') {
                    $(this).find('img').show();
                    $(this).find('span').hide();
                    openCardId = this.id;
                }else {
                    if(openCardId == openCardId2) return; //같은 카드 누른 경우 return

                    $(this).find('img').show();
                    $(this).find('span').hide();

                    var openCardSrc = $('#'+openCardId).find('img').attr('src');
                    var openCardSrc2 = $(this).find('img').attr('src');
                    openCardId2 = this.id;

                    if(openCardSrc == openCardSrc2) { // 일치
                        openCardId = '';
                        openCardId2 = '';
                        scorePlus();
                        if(++openedCtn == 10){
							gameState=''; //gameState 초기화
                            //alert('성공!!\n'+score+'점 입니다!');
							window.location.href="http://webdev.iptime.org:8080/kgy/insert_scoremode.jsp?score="+score;


                        }
                    }else { // 불일치
                        setTimeout(back, 1000);
                        scoreMinus();
                    }
                }
            });

            // 두개의 카드 다시 뒤집기
            function back() {
                $('#'+openCardId).find('img').hide();
                $('#'+openCardId).find('span').show();
                $('#'+openCardId2).find('img').hide();
                $('#'+openCardId2).find('span').show();
                $('#'+openCardId).removeClass('opened');
                $('#'+openCardId2).removeClass('opened');
                openCardId = '';
                openCardId2 = '';
            }

            // 점수 초기화
            function scoreInit(){
                score = 0;
                openedCtn = 0;
                $('#score').text(score);
            }
            // 점수 증가
            function scorePlus(){
                score += 10;
                $('#score').text(score);
            }
            // 점수 감소
            function scoreMinus(){
                score -= 5;
                $('#score').text(score);
            }

            $(document).on('click', '#startBtn', function(){
                if(gameState == '') {
                    startGame();
                    gameState = 'alreadyStart'
                }
				if(gameState != 'ingame'){
                  document.getElementById("startBtn").disabled = true;}
            });


  </script>
 </head>
 <body>
  <div class="container">
    <div class="row">
      <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
        <div class="card card-signin my-5">
          <div class="card-body">

            <div>
			<button id='scoreBtn'><span>score : <span id='score' name='score'>0

							</span></span></button><br><br>

                <div id='countDown'>준비
                </div>
				<div id='exit' onclick="location.href='http://webdev.iptime.org:8080/kgy/modeselect.html'">X</div><br><br>
                <table id='cardTable'>
                </table>
                <div id='info'>
                    start 버튼을 눌러주세요<br>
                </div>
		    <div>

                <div id='username' name='username' ><%=username%>

                </div><%
								if(rs.next()){
									String point=rs.getString("point");

							%>
				<div id='maxscore' name='maxscore'><%=point%>
				<%}
							%></div>
							<div><button id='startBtn'>start</button></div>

            </div>
        </div>
        </div>
      </div>
    </div>
  </div>
 </body>
</html>
<%
		}finally{
			if(rs != null) try{rs.close();}catch(SQLException ex){}
			if(stmt != null) try{stmt.close();} catch(SQLException ex){}
			if(conn != null) try{conn.close();} catch(SQLException ex){}
		}

%>
