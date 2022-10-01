//960,512
int dashboardWindowWidth = 960;
int dashboardWindowHeight = 512;

class DashboardApplet extends PApplet {

class PlayerRow {
 String leftOrRight;
 int index;
 ControlP5 cp5;
 int x,y,width,height;
 String number,name,score;
 int falls = 0;
 int numberWidth, nameWidth, circlesWidth;
 
 Textlabel numberLabel,nameLabel,scoreLabel;
 
 PlayerRow(String leftOrRight, int index,
           ControlP5 cp5,
           int x, int y, int width, int height, 
           String number, String name, String score,
           int numberWidth, int nameWidth, int circlesWidth){
   
   this.leftOrRight = leftOrRight;
   this.index = index;
   this.cp5 = cp5;
   this.x = x;
   this.y = y;
   this.width = width;
   this.height = height;
   this.number = number;
   this.name = name;
   this.score = score;
   this.numberWidth = numberWidth;
   this.nameWidth = nameWidth;
   this.circlesWidth = circlesWidth;
   
   PFont font = createFont("DejaVu Sans",height);
   
   numberLabel = cp5.addTextlabel(leftOrRight+"PlayerNumberLabel"+index)
                    .setText(number)
                    .setPosition(x,y)
                    .setSize(numberWidth,height)
                    .setColorValue(color(255,255,255))
                    .setFont(font);
   
   nameLabel = cp5.addTextlabel(leftOrRight+"PlayerNameLabel"+index)
                    .setText(name)
                    .setPosition(x+numberWidth,y)
                    .setSize(nameWidth,height)
                    .setColorValue(color(255,255,255))
                    .setFont(font);
   
   scoreLabel = cp5.addTextlabel(leftOrRight+"PlayerScoreLabel"+index)
                    .setText(score)
                    .setPosition(x+width-numberWidth,y)
                    .setSize(numberWidth,height)
                    .setColorValue(color(255,255,0))
                    .setFont(font);
 }
 
 public void Draw(PApplet p){
   
   
   int circleSpaceWidth = circlesWidth / 5;
   int radius = height / 2;
   //noStroke();
   for(int i=1; i<=falls; i++){
     fill(0,255,0);
     circle(x + numberWidth + nameWidth + circleSpaceWidth/2 + circleSpaceWidth * (i-1) , y + height / 2, radius);
     if(falls == 5)
     {
       fill(255,0,0);
       circle(x + numberWidth + nameWidth + circleSpaceWidth/2 + circleSpaceWidth * 4, y + height / 2, radius);
     }
   }
 }
}

class TeamColumn {
  ControlP5 cp5;
  String leftOrRight;
  int x,y,width,height;
  String name,country,score,falls;
  int timeouts = 0;
  int nameHeight, countryHeight, scoreHeight, fallsHeight;
  int teamTimeoutBoxesHeight;
  
  Textlabel nameLabel, countryLabel, scoreLabel,fallsLabel;
  
  int distanceBetween = 20;
  
  TeamColumn(ControlP5 cp5, String leftOrRight,
             int x, int y, int width, int height, 
             String name, String country, String score, String falls,
             int nameHeight, int countryHeight, int scoreHeight, int fallsHeight,
             int teamTimeoutBoxesHeight
             ){
   this.cp5 = cp5;
   this.leftOrRight = leftOrRight;
   this.x = x;
   this.y = y;
   this.width = width;
   this.height = height;
   this.name = name;
   this.country = country;
   this.score = score;
   this.falls = falls;
   this.nameHeight = nameHeight;
   this.countryHeight = countryHeight;
   this.scoreHeight = scoreHeight;
   this.fallsHeight = fallsHeight;
   this.teamTimeoutBoxesHeight = teamTimeoutBoxesHeight;
   
   textSize(nameHeight);
   nameLabel = cp5.addTextlabel(leftOrRight+"TeamNameLabel")
                    .setText(name)
                    .setPosition(x+width/2 - (int)textWidth(name)/2-(5),y+(height/6))
                    .setSize(width,nameHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(createFont("DejaVu Sans",nameHeight));
   
   textSize(countryHeight);
   countryLabel = cp5.addTextlabel(leftOrRight+"TeamCountryLabel")
                    .setText(country)
                    .setPosition(x+width/2 - (int)textWidth(country)/2-(5),y+nameHeight+(distanceBetween)+(height/6))
                    .setSize(width,nameHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(createFont("DejaVu Sans",countryHeight));
   
   textSize(scoreHeight);
   scoreLabel = cp5.addTextlabel(leftOrRight+"TeamScoreLabel")
                    .setText(score)
                    .setPosition(x+width/2 - (int)textWidth(score)/2-(5),y+nameHeight+countryHeight+(distanceBetween*2)+(height/6))
                    .setSize(width,scoreHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(createFont("DejaVu Sans",scoreHeight));
   
   fallsLabel = cp5.addTextlabel(leftOrRight+"TeamFallsLabel")
                    .setText(falls)
                    //.setPosition(x+width/2 - (int)textWidth(score)/2-(5),y+nameHeight+countryHeight+(distanceBetween*2)+(height/6))
                    .setSize(width,fallsHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(createFont("DejaVu Sans",fallsHeight));
   if(leftOrRight == "left"){
     fallsLabel.setPosition(x,height-fallsHeight);// = new Textlabel(cp5,falls,x,height-fallsHeight,width,fallsHeight);
   } else {
     textSize(fallsHeight);
     fallsLabel.setPosition(x+width-(int)textWidth(falls)-(5),height-fallsHeight);// = new Textlabel(cp5,falls,x+width-(int)textWidth(falls)-(5),height-fallsHeight,width,fallsHeight);
   }
  }
  
  public void Draw(PApplet p){
   
   int rectSpaceWidth = width/3;
   //noStroke();
   for(int i=1; i<=timeouts; i++){
     fill(255,255,0);
     rect(x+(rectSpaceWidth/2-teamTimeoutBoxesHeight/2)+rectSpaceWidth*(i-1),y+nameHeight+countryHeight+scoreHeight+(distanceBetween*3)+(height/6),teamTimeoutBoxesHeight,teamTimeoutBoxesHeight);
   }
  }
}
  
ControlP5 cp5;
  
int playerBoxWidth = dashboardWindowWidth * 7 / 22;
int playerNumberWidth = playerBoxWidth * 5 / 40;
int playerNameWidth = playerBoxWidth * 20 / 40;
int playerCirclesWidth = playerBoxWidth * 10 / 40;
int centerBoxWidth = dashboardWindowWidth * 8 / 22;
int teamBoxWidth = centerBoxWidth * 2 / 5;
//int teamNameWidth = teamBoxWidth * 
int timerBoxWidth = centerBoxWidth * 1 / 5;

int playersCount = 12;
int playerNameHeight = 20;
int teamNameHeight = 25;
int teamCountryHeight = 20;
int teamScoreHeight = 40;
int teamFallsHeight = 30;
int teamTimeoutBoxesHeight = 20;
int periodHeight = 40;
int timerHeight = 100;
int timeoutHeight = 50;

PlayerRow leftPlayers[], rightPlayers[];
TeamColumn leftTeamColumn, rightTeamColumn;
Textlabel periodLabel,timerLabel,timeoutTimerLabel,timeoutTextLabel;

public DashboardApplet() {
  super();
  PApplet.runSketch(new String[]{this.getClass().getName()}, this);
}

public void settings(){
  size(960,512);
  //fullScreen(1);
}

public void setup(){
  cp5 = new ControlP5(this);
  surface.setTitle("Табло");
  //surface.setResizable(true);
  
  leftPlayers = new PlayerRow[playersCount];
  rightPlayers = new PlayerRow[playersCount];
  for(int i=0; i<playersCount; i++){
    leftPlayers[i] = new PlayerRow("left", i,
                                   cp5,
                                   0,40+playerNameHeight*(i*2),playerBoxWidth,playerNameHeight,
                                   "", "", "0",
                                   playerNumberWidth,playerNameWidth,playerCirclesWidth
                                  );
    rightPlayers[i] = new PlayerRow("right", i,
                                    cp5,
                                    dashboardWindowWidth - playerBoxWidth,40+playerNameHeight*(i*2),playerBoxWidth,playerNameHeight,
                                    "", "", "0",
                                    playerNumberWidth,playerNameWidth,playerCirclesWidth
                                   );
  }
  
  leftTeamColumn = new TeamColumn(cp5,"left",
                            playerBoxWidth,0,teamBoxWidth,dashboardWindowHeight,
                            "", "", "0","0",
                            teamNameHeight, teamCountryHeight, teamScoreHeight,teamFallsHeight,
                            teamTimeoutBoxesHeight
                           );
  rightTeamColumn = new TeamColumn(cp5,"right",
                            dashboardWindowWidth-playerBoxWidth-teamBoxWidth,0,teamBoxWidth,dashboardWindowHeight,
                            "", "", "0","0",
                            teamNameHeight, teamCountryHeight, teamScoreHeight,teamFallsHeight,
                            teamTimeoutBoxesHeight
                           );
  textSize(periodHeight);
  periodLabel = cp5.addTextlabel("PeriodLabel")
                    .setText("0")
                    .setPosition(dashboardWindowWidth/2-(int)textWidth("0")/2-(5),(dashboardWindowHeight/4))
                    .setSize(timerBoxWidth,periodHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(createFont("DejaVu Sans",periodHeight));
  textSize(timerHeight);
  timerLabel = cp5.addTextlabel("TimerLabel")
                    .setText("0.0")
                    //.setPosition(dashboardWindowWidth/2-(int)textWidth("0.0")/2-(5),dashboardWindowHeight-(dashboardWindowHeight*9/20))
                    .setPosition(400,dashboardWindowHeight-(dashboardWindowHeight*9/20))
                    .setSize(timerBoxWidth,timerHeight)
                    .setColorValue(color(0,255,0))
                    .setFont(createFont("DejaVu Sans",timerHeight));
  textSize(playerNameHeight);
  timeoutTextLabel = cp5.addTextlabel("TimeoutTextLabel")
                        .setVisible(false)
                        .setText("Таймаут")
                        .setPosition(dashboardWindowWidth/2-(int)textWidth("Таймаут")/2-(5),timerLabel.getPosition()[1]+timerHeight+20)
                        .setSize(timerBoxWidth,timerHeight)
                        .setColorValue(color(255,255,0))
                        .setFont(createFont("DejaVu Sans",playerNameHeight));
  textSize(timeoutHeight);
  timeoutTimerLabel = cp5.addTextlabel("TimeoutTimerLabel")
                        .setVisible(false)
                        .setText("0.0")
                        .setPosition(dashboardWindowWidth/2-(int)textWidth("0.0")/2-(5),timeoutTextLabel.getPosition()[1]+playerNameHeight)
                        .setSize(timerBoxWidth,timerHeight)
                        .setColorValue(color(255,255,0))
                        .setFont(createFont("DejaVu Sans",timeoutHeight));
                        
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
     .setText("Сч")
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
     //.setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("right"+"FallsColumnLabel")
     .setText("Фолы")
     .setPosition(playerBoxWidth+centerBoxWidth+playerNumberWidth+playerNameWidth,0)
     .setSize(playerCirclesWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
  cp5.addTextlabel("right"+"ScoreColumnLabel")
     .setText("Сч")
     .setPosition(playerBoxWidth+centerBoxWidth+playerNumberWidth+playerNameWidth+playerCirclesWidth,0)
     .setSize(playerNumberWidth,teamFallsHeight)
     .setColorValue(color(255,255,255))
     .setFont(columnsLabelFont);
}

public void SetTimerLabelPosition(String text){
  //textSize(timerHeight);
  //timerLabel.setPosition(dashboardWindowWidth/2-(int)textWidth(text)/2-(5), dashboardWindowHeight-(dashboardWindowHeight*9/20));
  
  //timerLabel.setPosition(playerBoxWidth, dashboardWindowHeight-(dashboardWindowHeight/3));
  
  if(timerLabel.get().getText().length() == 5){
    timerLabel.setPosition(330, dashboardWindowHeight-(dashboardWindowHeight*9/20));
  } else if(timerLabel.get().getText().length() == 4){
    timerLabel.setPosition(360, dashboardWindowHeight-(dashboardWindowHeight*9/20));
  } else if(timerLabel.get().getText().length() == 3){
    timerLabel.setPosition(400, dashboardWindowHeight-(dashboardWindowHeight*9/20));
  }
}
public void SetTimeoutTimerLabelPosition(String text){
  //textSize(timeoutHeight);
  //timeoutTimerLabel.setPosition(dashboardWindowWidth/2-(int)textWidth(text)/2-(5), timeoutTextLabel.getPosition()[1]+playerNameHeight);
  
  timeoutTimerLabel.setPosition(430, timeoutTextLabel.getPosition()[1]+playerNameHeight);
}

//public void pre() {
//  if (dashboardWindowWidth != width || dashboardWindowHeight != height) {
//    // Sketch window has resized
//    dashboardWindowWidth = width;
//    dashboardWindowHeight = height;
//  }
//}

public void draw(){
  background(0);
  
  for(int i=0; i<playersCount; i++){
    leftPlayers[i].Draw(this);
    rightPlayers[i].Draw(this);
  }
  leftTeamColumn.Draw(this);
  rightTeamColumn.Draw(this);
  
  //debug lines
  stroke(255,255,255);
  
  line(0,40,playerBoxWidth,40);
  line(playerBoxWidth+centerBoxWidth,40,playerBoxWidth+centerBoxWidth+playerBoxWidth,40);
  
  line(playerNumberWidth,0,playerNumberWidth,dashboardWindowHeight);
  line(playerNumberWidth+playerNameWidth,0,playerNumberWidth+playerNameWidth,dashboardWindowHeight);
  line(playerBoxWidth-playerNumberWidth,0,playerBoxWidth-playerNumberWidth,dashboardWindowHeight);
  line(playerBoxWidth,0,playerBoxWidth,dashboardWindowHeight);
  
  line(dashboardWindowWidth - playerBoxWidth,0,dashboardWindowWidth - playerBoxWidth,dashboardWindowHeight);
  line(dashboardWindowWidth - playerBoxWidth+playerNumberWidth,0,dashboardWindowWidth - playerBoxWidth+playerNumberWidth,dashboardWindowHeight);
  line(dashboardWindowWidth - playerBoxWidth+playerNumberWidth+playerNameWidth,0,dashboardWindowWidth - playerBoxWidth+playerNumberWidth+playerNameWidth,dashboardWindowHeight);
  line(dashboardWindowWidth - playerNumberWidth,0,dashboardWindowWidth - playerNumberWidth,dashboardWindowHeight);
  
  /*
  line(playerBoxWidth+teamBoxWidth,0,playerBoxWidth+teamBoxWidth,dashboardWindowHeight);
  line(dashboardWindowWidth - playerBoxWidth - teamBoxWidth,0,dashboardWindowWidth - playerBoxWidth - teamBoxWidth,dashboardWindowHeight);
  line(dashboardWindowWidth/2,0,dashboardWindowWidth/2,dashboardWindowHeight);
  */
}
}
