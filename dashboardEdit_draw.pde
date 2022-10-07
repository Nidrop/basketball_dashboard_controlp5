int dashboardEditWindowWidth = 1080;
int dashboardEditWindowHeight = 512;

int playerBoxWidth = dashboardEditWindowWidth * 11 / 30;
int playerNumberWidth = playerBoxWidth * 5 / 40;
int playerNameWidth = playerBoxWidth * 16 / 40;
int playerCirclesWidth = playerBoxWidth * 10 / 40;
int playerScoreWidth = playerBoxWidth * 9 / 40;
int centerBoxWidth = dashboardEditWindowWidth * 8 / 30;
int teamBoxWidth = centerBoxWidth * 2 / 5;
int periodBoxWidth = centerBoxWidth * 1 / 5;

int playersCount = 12;
int playerNameHeight = 20;
int teamNameHeight = 25;
int teamCountryHeight = 20;
int teamScoreHeight = 40;
int teamFallsHeight = 30;
int teamTimeoutBoxesHeight = 20;
int periodHeight = 40;
int timerHeight = 80;

PlayerRowEdit[] leftPlayers, rightPlayers;
TeamColumnEdit leftTeamColumn, rightTeamColumn;
PeriodEdit periodEdit;
TimerEdit timerEdit;

int leftScoreSum, rightScoreSum;

PFont buttonsFont;

void initDashboardEdit(){
  String LeftPlayerNumbers[] = new String[playersCount];
  String LeftPlayerNames[] = new String[playersCount];
  LeftPlayerNumbers[0] = "00";
  LeftPlayerNumbers[1] = "0";
  LeftPlayerNumbers[2] = "5";
  LeftPlayerNumbers[3] = "7";
  LeftPlayerNumbers[4] = "8";
  LeftPlayerNumbers[5] = "12";
  LeftPlayerNumbers[6] = "26";
  LeftPlayerNumbers[7] = "42";
  LeftPlayerNumbers[8] = "48";
  LeftPlayerNumbers[9] = "55";
  LeftPlayerNumbers[10] = "N";
  LeftPlayerNumbers[11] = "N";
  LeftPlayerNames[0] = "MEIER, J.";
  LeftPlayerNames[1] = "JONES, M.";
  LeftPlayerNames[2] = "SMITH, E.";
  LeftPlayerNames[3] = "FRANK, Y.";
  LeftPlayerNames[4] = "NANCE, L.";
  LeftPlayerNames[5] = "KING, H.";
  LeftPlayerNames[6] = "RUSH, S.";
  LeftPlayerNames[7] = "JIMINEZ, M.";
  LeftPlayerNames[8] = "SANCHES, N.";
  LeftPlayerNames[9] = "MANOS, K.";
  LeftPlayerNames[10] = "NONE";
  LeftPlayerNames[11] = "NONE";
  String RightPlayerNumbers[] = new String[playersCount];
  String RightPlayerNames[] = new String[playersCount];
  RightPlayerNumbers[0] = "00";
  RightPlayerNumbers[1] = "0";
  RightPlayerNumbers[2] = "3";
  RightPlayerNumbers[3] = "5";
  RightPlayerNumbers[4] = "11";
  RightPlayerNumbers[5] = "16";
  RightPlayerNumbers[6] = "34";
  RightPlayerNumbers[7] = "37";
  RightPlayerNumbers[8] = "62";
  RightPlayerNumbers[9] = "99";
  RightPlayerNumbers[10] = "N";
  RightPlayerNumbers[11] = "N";
  RightPlayerNames[0] = "HUE, S.";
  RightPlayerNames[1] = "HASSAN, Y.";
  RightPlayerNames[2] = "MOUSSA, M";
  RightPlayerNames[3] = "RAMMIREZ, J.";
  RightPlayerNames[4] = "CHEN, Z.";
  RightPlayerNames[5] = "WANG, L.";
  RightPlayerNames[6] = "LEE, B.";
  RightPlayerNames[7] = "KIM, T.";
  RightPlayerNames[8] = "HUBER, R.";
  RightPlayerNames[9] = "DAVID, M.";
  RightPlayerNames[10] = "NONE";
  RightPlayerNames[11] = "NONE";
  String LeftTeamName = "GENEVA";
  String LeftTeamCountry = "COUNTRY1";
  String LeftTeamScore = "0";
  String LeftTeamFalls = "0";
  String RightTeamName = "WATOWN";
  String RightTeamCountry = "COUNTRY2";
  String RightTeamScore = "0";
  String RightTeamFalls = "0";
  
  buttonsFont = createFont("DejaVu Sans",13);
  
  leftPlayers = new PlayerRowEdit[playersCount];
  rightPlayers = new PlayerRowEdit[playersCount];
  for(int i=0; i<playersCount; i++){
    leftPlayers[i] = new PlayerRowEdit("left",i,
                                   cp5,
                                   0,40+playerNameHeight*(i*2),playerBoxWidth,playerNameHeight,
                                   LeftPlayerNumbers[i], LeftPlayerNames[i],"0",
                                   playerNumberWidth,playerNameWidth,playerCirclesWidth
                                  );
    rightPlayers[i] = new PlayerRowEdit("right",i,
                                    cp5,
                                    dashboardEditWindowWidth - playerBoxWidth,40+playerNameHeight*(i*2),playerBoxWidth,playerNameHeight,
                                    RightPlayerNumbers[i], RightPlayerNames[i],"0",
                                    playerNumberWidth,playerNameWidth,playerCirclesWidth
                                   );
  }
  leftTeamColumn = new TeamColumnEdit(cp5,"left",
                            playerBoxWidth,0,teamBoxWidth,dashboardEditWindowHeight,
                            LeftTeamName, LeftTeamCountry, LeftTeamScore,LeftTeamFalls,
                            teamNameHeight, teamCountryHeight, teamScoreHeight,teamFallsHeight,
                            teamTimeoutBoxesHeight
                           );
  rightTeamColumn = new TeamColumnEdit(cp5,"right",
                            dashboardEditWindowWidth-playerBoxWidth-teamBoxWidth,0,teamBoxWidth,dashboardEditWindowHeight,
                            RightTeamName, RightTeamCountry, RightTeamScore,RightTeamFalls,
                            teamNameHeight, teamCountryHeight, teamScoreHeight,teamFallsHeight,
                            teamTimeoutBoxesHeight
                           );
  
  periodEdit = new PeriodEdit(cp5,
                              playerBoxWidth+teamBoxWidth,(dashboardWindowHeight/4),periodBoxWidth,periodHeight+40,
                              periodHeight,
                              "0");
  timerEdit = new TimerEdit(cp5,
                            playerBoxWidth,(dashboardWindowHeight*3/5),centerBoxWidth,timerHeight+60,
                            timerHeight,
                            0);
  
  cp5.addTextlabel("left"+"NumberColumnLabel")
     .setText("№")
     .setPosition(0,0)
     .setSize(playerNumberWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("left"+"NameColumnLabel")
     .setText("Ф.И.")
     .setPosition(playerNumberWidth,0)
     .setSize(playerNameWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("left"+"FallsColumnLabel")
     .setText("Фолы")
     .setPosition(playerNumberWidth+playerNameWidth,0)
     .setSize(playerCirclesWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("left"+"ScoreColumnLabel")
     .setText("Очки")
     .setPosition(playerNumberWidth+playerNameWidth+playerCirclesWidth,0)
     .setSize(playerNumberWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
     
  cp5.addTextlabel("right"+"NumberColumnLabel")
     .setText("№")
     .setPosition(playerBoxWidth+centerBoxWidth,0)
     .setSize(playerNumberWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("right"+"NameColumnLabel")
     .setText("Ф.И.")
     .setPosition(playerBoxWidth+centerBoxWidth+playerNumberWidth,0)
     .setSize(playerNameWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("right"+"FallsColumnLabel")
     .setText("Фолы")
     .setPosition(playerBoxWidth+centerBoxWidth+playerNumberWidth+playerNameWidth,0)
     .setSize(playerCirclesWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("right"+"ScoreColumnLabel")
     .setText("Очки")
     .setPosition(playerBoxWidth+centerBoxWidth+playerNumberWidth+playerNameWidth+playerCirclesWidth,0)
     .setSize(playerNumberWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
}

void calculateTeamsScore(){
  leftScoreSum = 0;
  rightScoreSum = 0;
  for(int i=0; i<playersCount; i++){
    leftPlayers[i].Draw(this);
    rightPlayers[i].Draw(this);
    
    leftScoreSum += Integer.parseInt(leftPlayers[i].scoreLabel.getStringValue());
    rightScoreSum += Integer.parseInt(rightPlayers[i].scoreLabel.getStringValue());
  }
  
  leftTeamColumn.scoreLabel.setText(String.valueOf(leftScoreSum));
  rightTeamColumn.scoreLabel.setText(String.valueOf(rightScoreSum));
  textSize(teamScoreHeight);
  leftTeamColumn.scoreLabel.setPosition(playerBoxWidth+teamBoxWidth/2-(int)textWidth(String.valueOf(leftScoreSum))/2-(5),(dashboardWindowHeight/3));
  rightTeamColumn.scoreLabel.setPosition(dashboardEditWindowWidth-playerBoxWidth-teamBoxWidth/2-(int)textWidth(String.valueOf(rightScoreSum))/2-(5),(dashboardWindowHeight/3));
  dashboard.leftTeamColumn.scoreLabel.setText(String.valueOf(leftScoreSum));
  dashboard.rightTeamColumn.scoreLabel.setText(String.valueOf(rightScoreSum));
  dashboard.leftTeamColumn.scoreLabel.setPosition(dashboard.playerBoxWidth+dashboard.teamBoxWidth/2-(int)textWidth(String.valueOf(leftScoreSum))/2-(dashboard.leftTeamColumn.scoreLabel.get().getText().length()*5),(dashboardWindowHeight/3));
  dashboard.rightTeamColumn.scoreLabel.setPosition(dashboardWindowWidth-dashboard.playerBoxWidth-dashboard.teamBoxWidth/2-(int)textWidth(String.valueOf(rightScoreSum))/2-(dashboard.rightTeamColumn.scoreLabel.get().getText().length()*5),(dashboardWindowHeight/3));
}

void drawDashboardEdit(){
  
  leftTeamColumn.Draw(this);
  rightTeamColumn.Draw(this);
  
  periodEdit.Draw(this);
  timerEdit.Draw(this);
}
