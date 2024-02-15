class AutosaveButton {
  ControlP5 cp;
  int x, y, width, height;
  
  boolean enabled = false;
  int duration = 1000*60; //1 min
  int elapsed = 0;
  
  Button btn;
  
  AutosaveButton(ControlP5 cp,
                int x, int y, int width, int height)
  {
    this.cp = cp;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
     
    btn = cp.addButton("autousaveButton")
                       .setCaptionLabel("включить автосохранение")
                       .setPosition(x,y)
                       .setSize(width,height)
                       .setValue(0)
                       .setFont(buttonsFont)
                       .addCallback(new CallbackListener(){
                          public void controlEvent(CallbackEvent theEvent) {
                            if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
                              if(enabled){
                                enabled = false;
                                btn.setCaptionLabel("включить автосохранение");
                              } else {
                                enabled = true;
                                elapsed = duration;
                                btn.setCaptionLabel("отключить автосохранение");
                              }
                            }
                          }
                        });
  }
}

void saveSession(){
  println("saving session");
  
  JSONObject sessionJson = new JSONObject();
  
  float[] radioValues;
  int timeouts;
  
  sessionJson.setString("period" ,periodEdit.periodLabel.getStringValue());
  //sessionJson.setInt("periodTime" , timerEdit.periodTime);
  
  //left
  sessionJson.setString("left"+"TeamName" , ((Textfield)cp5.getController("left"+"TeamNameTextfield")).getText());
  sessionJson.setString("left"+"TeamCountry" , ((Textfield)cp5.getController("left"+"TeamCountryTextfield")).getText());
  sessionJson.setString("left"+"TeamFalls" , leftTeamColumn.fallsLabel.getStringValue());
  radioValues = ((RadioButton)cp5.getGroup("left"+"TeamTimeoutsRadiobutton")).getArrayValue();
  timeouts = 0;
  for(int i=0; i<radioValues.length; i++)
    {
      if(radioValues[i] == 1.0)
      {
        timeouts = i+1;
        break;
      }
    }
  sessionJson.setInt("left"+"TeamTimeouts" , timeouts);
  JSONArray leftPlayersJson = new JSONArray();
  for(int i=0; i<playersCount; i++){
    JSONObject pj = new JSONObject();
    pj.setString("number",((Textfield)cp5.getController("left"+"PlayerNumberTextfield"+i)).getText());
    pj.setString("name",((Textfield)cp5.getController("left"+"PlayerNameTextfield"+i)).getText());
    pj.setString("score",leftPlayers[i].scoreLabel.getStringValue());
    float[] values = ((RadioButton)cp5.getGroup("left"+"PlayerFallsRadiobutton"+i)).getArrayValue();
    int falls = 0;
    for(int j=0; j<values.length; j++)
    {
      if(values[j] == 1.0)
      {
        falls = j+1;
        break;
      }
    }
    pj.setInt("falls", falls);
    
    leftPlayersJson.setJSONObject(i, pj);
  }
  sessionJson.setJSONArray("left"+"Players", leftPlayersJson);
  
  //right
  sessionJson.setString("right"+"TeamName" , ((Textfield)cp5.getController("right"+"TeamNameTextfield")).getText());
  sessionJson.setString("right"+"TeamCountry" , ((Textfield)cp5.getController("right"+"TeamCountryTextfield")).getText());
  sessionJson.setString("right"+"TeamFalls" , rightTeamColumn.fallsLabel.getStringValue());
  radioValues = ((RadioButton)cp5.getGroup("right"+"TeamTimeoutsRadiobutton")).getArrayValue();
  timeouts = 0;
  for(int i=0; i<radioValues.length; i++)
    {
      if(radioValues[i] == 1.0)
      {
        timeouts = i+1;
        break;
      }
    }
  sessionJson.setInt("right"+"TeamTimeouts" , timeouts);
  JSONArray rightPlayersJson = new JSONArray();
  for(int i=0; i<playersCount; i++){
    JSONObject pj = new JSONObject();
    pj.setString("number",((Textfield)cp5.getController("right"+"PlayerNumberTextfield"+i)).getText());
    pj.setString("name",((Textfield)cp5.getController("right"+"PlayerNameTextfield"+i)).getText());
    pj.setString("score",rightPlayers[i].scoreLabel.getStringValue());
    float[] values = ((RadioButton)cp5.getGroup("right"+"PlayerFallsRadiobutton"+i)).getArrayValue();
    int falls = 0;
    for(int j=0; j<values.length; j++)
    {
      if(values[j] == 1.0)
      {
        falls = j+1;
        break;
      }
    }
    pj.setInt("falls", falls);
    
    rightPlayersJson.setJSONObject(i, pj);
  }
  sessionJson.setJSONArray("right"+"Players", rightPlayersJson);
  
  saveJSONObject(sessionJson,"save/session.json");
  
  println("session saved successfully");
}

void tryReadSession(){
  try{
    JSONObject sessionJson = loadJSONObject("save/session.json");
    
    int index;
    String f;
    
    String p = sessionJson.getString("period");
    periodEdit.periodLabel.setText(p);
    ((Textlabel)dashboard.cp5.getController("PeriodLabel")).setText(p);
    //timerEdit.periodTime = sessionJson.getInt("periodTime");
    
    //left
    ((Textfield)cp5.getController("left"+"TeamNameTextfield")).setText(sessionJson.getString("left"+"TeamName"));
    ((Textfield)cp5.getController("left"+"TeamCountryTextfield")).setText(sessionJson.getString("left"+"TeamCountry"));
    f = sessionJson.getString("left"+"TeamFalls");
    leftTeamColumn.fallsLabel.setStringValue(f);
    ((Textlabel)dashboard.cp5.getController("left"+"TeamFallsLabel")).setText(f);
    index = sessionJson.getInt("left"+"TeamTimeouts");
    if(index > 0){
      ((RadioButton)cp5.getGroup("left"+"TeamTimeoutsRadiobutton")).activate(index-1);
    }
    JSONArray leftPlayersJson = sessionJson.getJSONArray("left"+"Players");
    for(int i=0; i<leftPlayersJson.size(); i++){
      JSONObject pj = leftPlayersJson.getJSONObject(i);
      ((Textfield)cp5.getController("left"+"PlayerNumberTextfield"+i)).setText(pj.getString("number"));
      ((Textfield)cp5.getController("left"+"PlayerNameTextfield"+i)).setText(pj.getString("name"));
      String sc = pj.getString("score");
      leftPlayers[i].scoreLabel.setText(sc);
      ((Textlabel)dashboard.cp5.getController("left"+"PlayerScoreLabel"+i)).setText(sc);
      int n = pj.getInt("falls");
      if(n > 0){
        ((RadioButton)cp5.getGroup("left"+"PlayerFallsRadiobutton"+i)).activate(n-1);
      }
    }
    
    //right
    ((Textfield)cp5.getController("right"+"TeamNameTextfield")).setText(sessionJson.getString("right"+"TeamName"));
    ((Textfield)cp5.getController("right"+"TeamCountryTextfield")).setText(sessionJson.getString("right"+"TeamCountry"));
    rightTeamColumn.fallsLabel.setStringValue(sessionJson.getString("right"+"TeamFalls"));
    f = sessionJson.getString("right"+"TeamFalls");
    rightTeamColumn.fallsLabel.setStringValue(f);
    ((Textlabel)dashboard.cp5.getController("right"+"TeamFallsLabel")).setText(f);
    index = sessionJson.getInt("right"+"TeamTimeouts");
    if(index > 0){
      ((RadioButton)cp5.getGroup("right"+"TeamTimeoutsRadiobutton")).activate(index-1);
    }
    JSONArray rightPlayersJson = sessionJson.getJSONArray("right"+"Players");
    for(int i=0; i<rightPlayersJson.size(); i++){
      JSONObject pj = rightPlayersJson.getJSONObject(i);
      ((Textfield)cp5.getController("right"+"PlayerNumberTextfield"+i)).setText(pj.getString("number"));
      ((Textfield)cp5.getController("right"+"PlayerNameTextfield"+i)).setText(pj.getString("name"));
      String sc = pj.getString("score");
      rightPlayers[i].scoreLabel.setText(sc);
      ((Textlabel)dashboard.cp5.getController("right"+"PlayerScoreLabel"+i)).setText(sc);
      int n = pj.getInt("falls");
      if(n > 0){
        ((RadioButton)cp5.getGroup("right"+"PlayerFallsRadiobutton"+i)).activate(n-1);
      }
    }
    
    println("session loaded successfully");
  }
  catch(Exception e){
    println("session is not loaded: "+e);
  }
}

void saveCrashLog(Throwable e){
  StringWriter sw = new StringWriter();
  PrintWriter pw = new PrintWriter(sw);
  e.printStackTrace(pw);
  String sStackTrace = sw.toString(); 
  
  JSONObject cj = new JSONObject();
  
  cj.setInt("periodTime" , timerEdit.periodTime);
  cj.setString("Exception", e.toString());
  cj.setString("StackTrace", sStackTrace);
  
  saveJSONObject(cj, "save/crash-"+year()+"-"+month()+"-"+day()+"T"+hour()+":"+minute()+":"+second()+".log");
}
