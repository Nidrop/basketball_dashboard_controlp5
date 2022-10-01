class PlayerRowEdit {
 String leftOrRight;
 int index;
 ControlP5 cp5;
 int x,y,width,height;
 String number,name,score;
 int numberWidth, nameWidth, circlesWidth;
 
 Textlabel scoreLabel;
 
 PlayerRowEdit(String leftOrRight, int index,
               ControlP5 cp5,
               int x, int y, int width, int height, 
               String number, String name, String score,
               int numberWidth, int nameWidth, int circlesWidth)
 {
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
   
   PFont font = createFont("DejaVu Sans",height-3);
   
   cp5.addTextfield(leftOrRight+"PlayerNumberTextfield"+index)
      .setPosition(x+(2),y)
      .setSize(numberWidth-(4),height)
      .setColor(color(255,255,255))
      .setFont(font)
      .setAutoClear(false)
      //.addCallback(new CallbackListener(){
      //  public void controlEvent(CallbackEvent theEvent) {
      //    if (theEvent.getAction()==ControlP5.PRESS) {
      //      Textfield tf = (Textfield)theEvent.getController();
      //      String[] ss = tf.getName().split("PlayerNumberTextfield");
      //      Textlabel tl = (Textlabel)dashboard.cp5.getController(ss[0]+"PlayerNumberLabel"+ss[1]);
      //      tl.setText(tf.getText());
      //    }
      //  }
      //})
      ;
   cp5.getController(leftOrRight+"PlayerNumberTextfield"+index).getCaptionLabel().setVisible(false);
   
   cp5.addTextfield(leftOrRight+"PlayerNameTextfield"+index)
      .setPosition(x+numberWidth+(2),y)
      .setSize(nameWidth-(4),height)
      .setColor(color(255,255,255))
      .setFont(font)
      .setAutoClear(false);
   cp5.getController(leftOrRight+"PlayerNameTextfield"+index).getCaptionLabel().setVisible(false);
   
   cp5.addRadioButton(leftOrRight+"PlayerFallsRadiobutton"+index)
      .setPosition(x+numberWidth+nameWidth+(3),y)
      .setSize(height-(2) ,height)
      .setItemsPerRow(5)
      .addItem(leftOrRight+"PlayerFallsRadiobutton"+index+"toggle"+"0", 0)
      .addItem(leftOrRight+"PlayerFallsRadiobutton"+index+"toggle"+"1", 1)
      .addItem(leftOrRight+"PlayerFallsRadiobutton"+index+"toggle"+"2", 2)
      .addItem(leftOrRight+"PlayerFallsRadiobutton"+index+"toggle"+"3", 3)
      .addItem(leftOrRight+"PlayerFallsRadiobutton"+index+"toggle"+"4", 4);
   RadioButton radiobutton = (RadioButton)cp5.getGroup(leftOrRight+"PlayerFallsRadiobutton"+index);
   for(int i=0;i<=4;i++)
   {
     radiobutton.getItem(i).getCaptionLabel().setVisible(false);
     //radiobutton.getItem(i).setColorBackground(color(0,0,100));
   }
   
   cp5.addButton(leftOrRight+"PlayerScoreReset"+index)
      .setCaptionLabel("⟲")
      .setPosition(x+width - playerScoreWidth+(1),y)
      .setSize(height,height)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            scoreLabel.setText(String.valueOf(0));
            
            String[] ss = theEvent.getController().getName().split("PlayerScoreReset");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"PlayerScoreLabel"+ss[1]);
            t.setText(String.valueOf(0));
            
            calculateTeamsScore();
          }
        }
      });
   
   cp5.addButton(leftOrRight+"PlayerScoreSub"+index)
      .setCaptionLabel("-")
      .setPosition(x+width - playerScoreWidth+height+(2),y)
      .setSize(height,height)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(scoreLabel.getStringValue());
            val--;
            scoreLabel.setText(String.valueOf(val));
            
            String[] ss = theEvent.getController().getName().split("PlayerScoreSub");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"PlayerScoreLabel"+ss[1]);
            t.setText(String.valueOf(val));
            
            calculateTeamsScore();
          }
        }
      });
   
   scoreLabel = cp5.addTextlabel(leftOrRight+"PlayerScoreLabel"+index)
                    .setText(score)
                    .setPosition(x+width-playerScoreWidth+height*2,y)
                    .setSize(numberWidth,height)
                    .setColorValue(color(255,255,0))
                    .setFont(font);
   //scoreLabel = new Textlabel(cp5,score,x+width-playerScoreWidth+height*2,y,numberWidth,height);
   //scoreLabel.setColorValue(0xffff0000);
   //scoreLabel.setFont(font);
   
   cp5.addButton(leftOrRight+"PlayerScoreAdd"+index)
      .setCaptionLabel("+")
      .setPosition(x+width - height,y)
      .setSize(height,height)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(scoreLabel.getStringValue());
            val++;
            scoreLabel.setText(String.valueOf(val));
            
            String[] ss = theEvent.getController().getName().split("PlayerScoreAdd");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"PlayerScoreLabel"+ss[1]);
            t.setText(String.valueOf(val));
            
            calculateTeamsScore();
          }
        }
      });
 }
 
 public void Draw(PApplet p){
   //scoreLabel.draw(p);
 }
}

class TeamColumnEdit {
  ControlP5 cp5;
  String leftOrRight;
  int x,y,width,height;
  String name,country,score,falls;
  int nameHeight, countryHeight, scoreHeight, fallsHeight;
  int teamTimeoutBoxesHeight;
  
  Textlabel nameLabel, countryLabel, scoreLabel,fallsLabel;
  
  int distanceBetween = 20;
  
  TeamColumnEdit(ControlP5 cp5, String leftOrRight,
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
   
   PFont nameFont = createFont("DejaVu Sans",nameHeight-3);
   
   cp5.addTextfield(leftOrRight+"TeamNameTextfield")
      .setPosition(x+(3),y+(height/6))
      .setSize(width-(6),nameHeight)
      .setColor(color(255,255,255))
      .setFont(nameFont)
      .setAutoClear(false);
   cp5.getController(leftOrRight+"TeamNameTextfield").getCaptionLabel().setVisible(false);
   
   PFont countryFont = createFont("DejaVu Sans",countryHeight-4);   
   cp5.addTextfield(leftOrRight+"TeamCountryTextfield")
      .setPosition(x+(3),y+nameHeight+(distanceBetween)+(height/6))
      .setSize(width-(6),countryHeight)
      .setColor(color(255,255,255))
      .setFont(countryFont)
      .setAutoClear(false);
   cp5.getController(leftOrRight+"TeamCountryTextfield").getCaptionLabel().setVisible(false);
   
   PFont scoreFont = createFont("DejaVu Sans",scoreHeight);
   textSize(scoreHeight);
   scoreLabel = cp5.addTextlabel(leftOrRight+"TeamScoreLabel")
                    .setText(score)
                    .setPosition(x+width/2 - (int)textWidth(score)/2-(5),y+nameHeight+countryHeight+(distanceBetween*2)+(height/6))
                    .setSize(width,scoreHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(scoreFont);
   //scoreLabel = new Textlabel(cp5,score,x+width/2 - (int)textWidth(score)/2-(5),y+nameHeight+countryHeight+(distanceBetween*2)+(height/6),width,scoreHeight);
   //scoreLabel.setColorValue(0xffffffff);
   //scoreLabel.setFont(scoreFont);
   
   cp5.addRadioButton(leftOrRight+"TeamTimeoutsRadiobutton")
      .setPosition(x+((width-teamTimeoutBoxesHeight*3)/3/2),y+nameHeight+countryHeight+scoreHeight+(distanceBetween*3)+(height/6))
      .setSize(teamTimeoutBoxesHeight, teamTimeoutBoxesHeight)
      .setItemsPerRow(3)
      .setSpacingColumn((width-teamTimeoutBoxesHeight*3)/3)
      .addItem(leftOrRight+"TeamTimeoutsRadiobuttonToggle"+"0", 0)
      .addItem(leftOrRight+"TeamTimeoutsRadiobuttonToggle"+"1", 1)
      .addItem(leftOrRight+"TeamTimeoutsRadiobuttonToggle"+"2", 2);
   RadioButton radiobutton = (RadioButton)cp5.getGroup(leftOrRight+"TeamTimeoutsRadiobutton");
   for(int i=0;i<=2;i++)
   {
     radiobutton.getItem(i).getCaptionLabel().setVisible(false);
     //radiobutton.getItem(i).setColorBackground(color(0,0,100));
   }
   
   PFont fallsFont = createFont("DejaVu Sans",fallsHeight);
   if(leftOrRight == "left"){
     fallsLabel = cp5.addTextlabel(leftOrRight+"TeamFallsLabel")
                    .setText(falls)
                    .setPosition(x,height-fallsHeight)
                    .setSize(width,fallsHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(fallsFont);
     //fallsLabel = new Textlabel(cp5,falls,x,height-fallsHeight,width,fallsHeight);
     //fallsLabel.setColorValue(0xffffffff);
     //fallsLabel.setFont(fallsFont);
     
    cp5.addButton(leftOrRight+"TeamFallsAdd")
      .setCaptionLabel("+")
      .setPosition(x+fallsHeight,height-fallsHeight)
      .setSize(fallsHeight/2,fallsHeight/2)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(fallsLabel.getStringValue());
            val++;
            fallsLabel.setText(String.valueOf(val));
            
            String[] ss = theEvent.getController().getName().split("TeamFallsAdd");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"TeamFallsLabel");
            t.setText(String.valueOf(val));
          }
        }
      });
    cp5.addButton(leftOrRight+"TeamFallsSub")
      .setCaptionLabel("-")
      .setPosition(x+fallsHeight,height-fallsHeight/2)
      .setSize(fallsHeight/2,fallsHeight/2)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(fallsLabel.getStringValue());
            val--;
            fallsLabel.setText(String.valueOf(val));
            
            String[] ss = theEvent.getController().getName().split("TeamFallsSub");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"TeamFallsLabel");
            t.setText(String.valueOf(val));
          }
        }
      });
      
   } else {
     textSize(fallsHeight);
     fallsLabel = cp5.addTextlabel(leftOrRight+"TeamFallsLabel")
                    .setText(falls)
                    .setPosition(x+width-fallsHeight,height-fallsHeight)
                    .setSize(width,fallsHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(fallsFont);
     //fallsLabel = new Textlabel(cp5,falls,x+width-fallsHeight,height-fallsHeight,width,fallsHeight);
     //fallsLabel.setColorValue(0xffffffff);
     //fallsLabel.setFont(fallsFont);
     
     cp5.addButton(leftOrRight+"TeamFallsAdd")
      .setCaptionLabel("+")
      .setPosition(x+width-fallsHeight-fallsHeight/2,height-fallsHeight)
      .setSize(fallsHeight/2,fallsHeight/2)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(fallsLabel.getStringValue());
            val++;
            fallsLabel.setText(String.valueOf(val));
            
            String[] ss = theEvent.getController().getName().split("TeamFallsAdd");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"TeamFallsLabel");
            t.setText(String.valueOf(val));
          }
        }
      });
    cp5.addButton(leftOrRight+"TeamFallsSub")
      .setCaptionLabel("-")
      .setPosition(x+width-fallsHeight-fallsHeight/2,height-fallsHeight/2)
      .setSize(fallsHeight/2,fallsHeight/2)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(fallsLabel.getStringValue());
            val--;
            fallsLabel.setText(String.valueOf(val));
            
            String[] ss = theEvent.getController().getName().split("TeamFallsSub");
            Textlabel t = (Textlabel)dashboard.cp5.getController(ss[0]+"TeamFallsLabel");
            t.setText(String.valueOf(val));
          }
        }
      });
   }
  }
  
  public void Draw(PApplet p){
    
  }
}

class PeriodEdit {
  ControlP5 cp5;
  int x, y, width, height;
  int periodHeight;
  String period;
  
  Textlabel periodLabel;
  
  PeriodEdit(ControlP5 cp5,
             int x, int y, int width, int height,
             int periodHeight,
             String period)
  {
    this.cp5 = cp5;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.periodHeight = periodHeight;
    this.period = period;
    
    textSize(periodHeight);
    PFont periodFont = createFont("DejaVu Sans",periodHeight-2);
    periodLabel = cp5.addTextlabel("PeriodLabel")
                    .setText(period)
                    .setPosition(x+width/2-(int)(textWidth(period)/2)-(3),y+(height-periodHeight)/2)
                    .setSize(width,periodHeight)
                    .setColorValue(color(255,255,255))
                    .setFont(periodFont);
    //periodLabel = new Textlabel(cp5, period, x+width/2-(int)(textWidth(period)/2)-(3), y+(height-periodHeight)/2, width, periodHeight);
    //periodLabel.setColorValue(0xffffffff);
    //periodLabel.setFont(periodFont);
    
    cp5.addButton("PeriodAdd")
      .setCaptionLabel("+")
      .setPosition(x,y)
      .setSize(width,(height-periodHeight)/2)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(periodLabel.getStringValue());
            val++;
            periodLabel.setText(String.valueOf(val));
            
            Textlabel t = (Textlabel)dashboard.cp5.getController("PeriodLabel");
            t.setText(String.valueOf(val));
          }
        }
      });
    cp5.addButton("PeriodSub")
      .setCaptionLabel("-")
      .setPosition(x,y+(height-periodHeight)/2 + periodHeight)
      .setSize(width,(height-periodHeight)/2)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            int val = Integer.parseInt(periodLabel.getStringValue());
            val--;
            periodLabel.setText(String.valueOf(val));
            
            Textlabel t = (Textlabel)dashboard.cp5.getController("PeriodLabel");
            t.setText(String.valueOf(val));
          }
        }
      });
  }
  
  void Draw(PApplet p){
    
  }
}

class TimerEdit {
  ControlP5 cp5;
  int x, y, width, height;
  int timerHeight;
  int periodTime;
  int timeoutTime;
  
  int firstSecondAfterPeriodTimer = 0;
  int firstSecondAfter5SecLeftPeriodTimer = 0;
  
  boolean isPaused = true, isPeriod = true, 
          isFirstSecondAfterPeriod = false,
          isFirstSecondAfter5SecLeftPeriod = false;
  
  //Textlabel timerLabel;
  Button timerPause;
  Textfield timerTextfield;
  
  TimerEdit(ControlP5 cp5,
             int x, int y, int width, int height,
             int timerHeight,
             int periodTime)
  {
    this.cp5 = cp5;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.timerHeight = timerHeight;
    this.periodTime = periodTime;
    
    textSize(timerHeight);
    PFont timerFont = createFont("DejaVu Sans",timerHeight-10);
    //timerLabel = cp5.addTextlabel("TimerLabel")
    //                .setText(TimerToString(periodTime))
    //                .setPosition(x+width/2-(int)(textWidth(TimerToString(periodTime))/2)-(3),y+(height-timerHeight)/3)
    //                .setSize(width,timerHeight)
    //                .setColorValue(color(0,255,0))
    //                .setFont(timerFont);
    timerTextfield = cp5.addTextfield("TimerTextfield")
                        .setPosition(x+(2),y+(height-timerHeight)/3+(5))
                        .setSize(width-(4),timerHeight-(10))
                        .setText("00:00.0")
                        .setColor(color(255,255,255))
                        .setFont(timerFont)
                        .setAutoClear(false);
    cp5.getController("TimerTextfield").getCaptionLabel().setVisible(false);
    
    cp5.addButton("TimerSet5")
      .setCaptionLabel("5 минут")
      .setPosition(x+(1),y)
      .setSize(width/3-(2),(height-timerHeight)/3)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            //timerEdit.periodTime = 5000;
            timerEdit.periodTime = 1000*60*5;
            
            timerEdit.isPaused = true;
            timerEdit.timerPause.setCaptionLabel("старт");
            
            timerEdit.timerTextfield.setLock(false);
            timerEdit.timerTextfield.setText(TimerToStringEdit(timerEdit.periodTime));
            
            String dashboardTimeString = TimerToString(timerEdit.periodTime);
            dashboard.timerLabel.setText(dashboardTimeString);
            dashboard.SetTimerLabelPosition(dashboardTimeString);
          }
        }
      });
    cp5.addButton("TimerSet10")
      .setCaptionLabel("10 минут")
      .setPosition(x+width/3+(1),y)
      .setSize(width/3-(2),(height-timerHeight)/3)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            //timerEdit.periodTime = 10000;
            timerEdit.periodTime = 1000*60*10;
            
            timerEdit.isPaused = true;
            timerEdit.timerPause.setCaptionLabel("старт");
            
            timerEdit.timerTextfield.setLock(false);
            timerEdit.timerTextfield.setText(TimerToStringEdit(timerEdit.periodTime));
            
            String dashboardTimeString = TimerToString(timerEdit.periodTime);
            dashboard.timerLabel.setText(dashboardTimeString);
            dashboard.SetTimerLabelPosition(dashboardTimeString);
          }
        }
      });
    cp5.addButton("TimerSet12")
      .setCaptionLabel("12 минут")
      .setPosition(x+width/3*2+(1),y)
      .setSize(width/3-(2),(height-timerHeight)/3)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            //timerEdit.periodTime = 12000;
            timerEdit.periodTime = 1000*60*12;
            
            timerEdit.isPaused = true;
            timerEdit.timerPause.setCaptionLabel("старт");
            
            timerEdit.timerTextfield.setLock(false);
            timerEdit.timerTextfield.setText(TimerToStringEdit(timerEdit.periodTime));
            
            String dashboardTimeString = TimerToString(timerEdit.periodTime);
            dashboard.timerLabel.setText(dashboardTimeString);
            dashboard.SetTimerLabelPosition(dashboardTimeString);
            
          }
        }
      });
      
    timerPause = cp5.addButton("TimerPause")
                    .setCaptionLabel("старт")
                    .setPosition(x+(1),y+timerHeight+(height-timerHeight)/3)
                    .setSize(width/2-(2),(height-timerHeight)/3)
                    .setValue(0)
                    .setFont(buttonsFont)
                    .addCallback(new CallbackListener(){
                      public void controlEvent(CallbackEvent theEvent) {
                        if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
                          
                          if(timerEdit.isPaused && timerEdit.periodTime > 0){
                            timerEdit.isPeriod = true;
              
                            dashboard.timeoutTimerLabel.setVisible(false);
                            dashboard.timeoutTextLabel.setVisible(false);
              
                            timerEdit.isPaused = false;
                            timerEdit.timerPause.setCaptionLabel("пауза");
                            timerEdit.timerTextfield.setLock(true);
                          }
                          else{
                            timerEdit.isPaused = true;
                            timerEdit.timerPause.setCaptionLabel("старт");
                            timerEdit.timerTextfield.setLock(false);
                          }
                        }
                      }
                 });
    cp5.addButton("TimerStop")
      .setCaptionLabel("стоп")
      .setPosition(x+width/2+(1),y+timerHeight+(height-timerHeight)/3)
      .setSize(width/2-(2),(height-timerHeight)/3)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            timerEdit.periodTime = 0;
            
            timerEdit.isPaused = true;
            timerEdit.timerPause.setCaptionLabel("старт");
            timerEdit.timerTextfield.setLock(false);
            timerEdit.timerTextfield.setText(TimerToStringEdit(timerEdit.periodTime));
            
            String dashboardTimeString = TimerToString(timerEdit.periodTime);
            dashboard.timerLabel.setText(dashboardTimeString);
            dashboard.SetTimerLabelPosition(dashboardTimeString);
          }
        }
      });
    cp5.addButton("TimerTimeout")
      .setCaptionLabel("таймаут")
      .setPosition(x+(1),y+timerHeight+(height-timerHeight)/3*2)
      .setSize(width-(2),(height-timerHeight)/3)
      .setValue(0)
      .setFont(buttonsFont)
      .addCallback(new CallbackListener(){
        public void controlEvent(CallbackEvent theEvent) {
          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
            
            if(timerEdit.isPeriod){
              timerEdit.isPeriod = false;
              //timerEdit.timeoutTime = 1000;
              timerEdit.timeoutTime = 1000 * 60;
              
              dashboard.timeoutTimerLabel.setVisible(true);
              dashboard.timeoutTextLabel.setVisible(true);
              
              timerEdit.isPaused = true;
              timerEdit.timerPause.setCaptionLabel("старт");
              timerEdit.timerTextfield.setLock(false);
            }
            else{
              timerEdit.isPeriod = true;
              
              dashboard.timeoutTimerLabel.setVisible(false);
              dashboard.timeoutTextLabel.setVisible(false);
            }
          }
        }
      });
  }
  
  String TimerToString(int timer){
    int min = timer / 60000;
    int ost = timer % 60000;
    int sec = ost / 1000;
    ost %= 1000;
    int mil = ost / 100;
    if(min>0){
      return (min>9
             ? String.valueOf(min)
             : "0"+String.valueOf(min))
             + ":" + 
             (sec>9
             ? String.valueOf(sec)
             : "0"+String.valueOf(sec));
    } else {
      return String.valueOf(sec)+"."+String.valueOf(mil);
    }
  }
  
  String TimerToStringEdit(int timer){
    int min = timer / 60000;
    int ost = timer % 60000;
    int sec = ost / 1000;
    ost %= 1000;
    int mil = ost / 100;
    
    String minString, secString;
    if(min>9){
      minString = String.valueOf(min);
    }
    else{
      minString = "0"+String.valueOf(min);
    }
    if(sec>9){
      secString = String.valueOf(sec);
    }
    else{
      secString = "0"+String.valueOf(sec);
    }
    return minString+":"+secString+"."+String.valueOf(mil);
  }
  
  int StringToTimerEdit(String s, int oldTimer){
    String min="",sec="",mil="";
    String ss[];
    ss = s.split(":");
    if(ss.length == 2){
      min = ss[0];
      s = ss[1];
    }
    else if(ss.length == 1){
      min="0";
    }
    ss = s.split("\\.");
    if(ss.length == 2){
      sec = ss[0];
      mil = ss[1];
    }
    else if(ss.length == 1){
      mil = "0";
      sec = ss[0];
    }
    
    try{
      return Integer.parseInt(mil)*100+Integer.parseInt(sec)*1000+Integer.parseInt(min)*60000;
    }
    catch(Exception e){
      return oldTimer;
    }
  }
  
  //void SetTimerLabelPosition(String text){
  //  textSize(timerHeight);
  //  timerLabel.setPosition(x+width/2-(int)(textWidth(text)/2)-(3), y+(height-timerHeight)/3);
  //}
  
  void Draw(PApplet p){
    if(isPeriod){
      if(periodTime>0 && !isPaused){
        periodTime -= deltaTime;
        
        String dashboardTimeString = TimerToString(periodTime);
        dashboard.SetTimerLabelPosition(dashboardTimeString);
        dashboard.timerLabel.setText(dashboardTimeString);
        
        timerTextfield.setText(TimerToStringEdit(periodTime));
        
        if(periodTime == 5000){
          isFirstSecondAfter5SecLeftPeriod = true;
          firstSecondAfter5SecLeftPeriodTimer = millis();
        }
        
        if(periodTime == 0){
          isPaused = true;
          timerPause.setCaptionLabel("старт");
          timerTextfield.setLock(false);
                            
          isFirstSecondAfterPeriod = true;
          firstSecondAfterPeriodTimer = millis();
        }
      }
      
      if(isFirstSecondAfterPeriod){
        if(millis() - firstSecondAfterPeriodTimer >= 1000){
          isFirstSecondAfterPeriod = false;
        }
      }
      
      if(isFirstSecondAfter5SecLeftPeriod){
        if(millis() - firstSecondAfter5SecLeftPeriodTimer >= 250){
          isFirstSecondAfter5SecLeftPeriod = false;
        }
      } 
    } 
    else 
    {
      if(timeoutTime>0){
        timeoutTime -= deltaTime;
        
        String dashboardTimeString = TimerToString(timeoutTime);
        dashboard.SetTimeoutTimerLabelPosition(dashboardTimeString);
        dashboard.timeoutTimerLabel.setText(dashboardTimeString);
      } 
    }
  }
}
