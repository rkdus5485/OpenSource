# project

최종적으로 총 5개의 파일이 사용되었습니다.

ForRank.java /
Insert_Pointmode.java /
Insert_Timermode.java /
Select_Pointmode.jsp /
Select_Timermode.jsp /

ForRank.java : 
Timer mode 와 Score mode의 전체 순위 1~3위까지 보여주도록 만든 파일입니다.

Insert_Pointmode.java : 
Score mode의 게임이 종료되면 해당 유저의 점수를 테이블에 기록하도록 하는 파일입니다.

Insert_Timermode.java : 
Timer mode의 게임이 종료되면 해당 유저의 시간 기록을 테이블에 기록하도록 하는 파일입니다.

Select_Pointmode.jsp : 
Score mode의 게임이 종료된 후, 기존 점수보다 높은 점수를 획득할 시 새롭게 테이블에 값을 업데이트 해주고, 아닐시에는 저장하지 않은 기능을 하는 파일입니다.

Select_Timermode.jsp : 
Timer moded의 게임이 종료된 후, 기존 시간보다 짧은 시간을 기록할 시에 새롭게 테이블에 값을 업데이트 해주고, 아닐시에는 저장하지 않는 기능을 하는 파일입니다.

위의 5가지 파일을 통해서 데이터베이스에 기록하거나, 값을 가져오는 기능들을 연동하여서 백앤드에서 데이터베이스가 필요한 경우 위의 파일을 이용하여 구현하였습니다