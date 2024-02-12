void controlEvent(ControlEvent theEvent) {
  
  RadioButton rb;
  for(int i=0;i<playersCount;i++){
      rb = (RadioButton)cp5.getGroup("left"+"PlayerFallsRadiobutton"+i);
      if(theEvent.isFrom(rb)) {
        float[] values = rb.getArrayValue();
        for(int j=0; j<values.length; j++)
        {
          if(values[j] == 1.0)
          {
            dashboard.leftPlayers[i].falls = j+1;
            break;
          }
          if(j == values.length - 1)
          {
            dashboard.leftPlayers[i].falls = 0;
          }
        }
      }
  }
  for(int i=0;i<playersCount;i++){
      rb = (RadioButton)cp5.getGroup("right"+"PlayerFallsRadiobutton"+i);
      if(theEvent.isFrom(rb)) {
        float[] values = rb.getArrayValue();
        for(int j=0; j<values.length; j++)
        {
          if(values[j] == 1.0)
          {
            dashboard.rightPlayers[i].falls = j+1;
            break;
          }
          if(j == values.length - 1)
          {
            dashboard.rightPlayers[i].falls = 0;
          }
        }
      }
  }
  rb = (RadioButton)cp5.getGroup("left"+"TeamTimeoutsRadiobutton");
  if(theEvent.isFrom(rb)) {
    float[] values = rb.getArrayValue();
    for(int j=0; j<values.length; j++)
    {
      if(values[j] == 1.0)
      {
        dashboard.leftTeamColumn.timeouts = j+1;
        break;
      }
      if(j == values.length - 1)
      {
        dashboard.leftTeamColumn.timeouts = 0;
      }
    }
  }
  rb = (RadioButton)cp5.getGroup("right"+"TeamTimeoutsRadiobutton");
  if(theEvent.isFrom(rb)) {
    float[] values = rb.getArrayValue();
    for(int j=0; j<values.length; j++)
    {
      if(values[j] == 1.0)
      {
        dashboard.rightTeamColumn.timeouts = j+1;
        break;
      }
      if(j == values.length - 1)
      {
        dashboard.rightTeamColumn.timeouts = 0;
      }
    }
  }
  
  Textfield tf;
  for(int i=0; i<playersCount; i++)
  {
    tf = (Textfield)cp5.getController("left"+"PlayerNumberTextfield"+i);
    if(theEvent.isFrom(tf))
    {
      Textlabel tl = (Textlabel)dashboard.cp5.getController("left"+"PlayerNumberLabel"+i);
      tl.setText(tf.getText());
    }
    tf = (Textfield)cp5.getController("left"+"PlayerNameTextfield"+i);
    if(theEvent.isFrom(tf))
    {
      Textlabel tl = (Textlabel)dashboard.cp5.getController("left"+"PlayerNameLabel"+i);
      tl.setText(tf.getText());
    }
    tf = (Textfield)cp5.getController("right"+"PlayerNumberTextfield"+i);
    if(theEvent.isFrom(tf))
    {
      Textlabel tl = (Textlabel)dashboard.cp5.getController("right"+"PlayerNumberLabel"+i);
      tl.setText(tf.getText());
    }
    tf = (Textfield)cp5.getController("right"+"PlayerNameTextfield"+i);
    if(theEvent.isFrom(tf))
    {
      Textlabel tl = (Textlabel)dashboard.cp5.getController("right"+"PlayerNameLabel"+i);
      tl.setText(tf.getText());
    }
  }
  tf = (Textfield)cp5.getController("left"+"TeamNameTextfield");
  if(theEvent.isFrom(tf))
  {
    Textlabel tl = (Textlabel)dashboard.cp5.getController("left"+"TeamNameLabel");
    textSize(dashboard.leftTeamColumn.nameHeight);
    tl.setPosition(dashboard.leftTeamColumn.x+dashboard.leftTeamColumn.width/2 - (int)textWidth(tf.getText())/2-(5),dashboard.leftTeamColumn.y+(dashboard.leftTeamColumn.height/6));
    tl.setText(tf.getText());
  }
  tf = (Textfield)cp5.getController("left"+"TeamCountryTextfield");
  if(theEvent.isFrom(tf))
  {
    Textlabel tl = (Textlabel)dashboard.cp5.getController("left"+"TeamCountryLabel");
    textSize(dashboard.leftTeamColumn.countryHeight);
    tl.setPosition(dashboard.leftTeamColumn.x+dashboard.leftTeamColumn.width/2 - (int)textWidth(tf.getText())/2-(5),dashboard.leftTeamColumn.y+dashboard.leftTeamColumn.nameHeight+(dashboard.leftTeamColumn.distanceBetween)+(dashboard.leftTeamColumn.height/6));
    tl.setText(tf.getText());
  }
  tf = (Textfield)cp5.getController("right"+"TeamNameTextfield");
  if(theEvent.isFrom(tf))
  {
    Textlabel tl = (Textlabel)dashboard.cp5.getController("right"+"TeamNameLabel");
    textSize(dashboard.rightTeamColumn.nameHeight);
    tl.setPosition(dashboard.rightTeamColumn.x+dashboard.rightTeamColumn.width/2 - (int)textWidth(tf.getText())/2-(5),dashboard.rightTeamColumn.y+(dashboard.rightTeamColumn.height/6));
    tl.setText(tf.getText());
  }
  tf = (Textfield)cp5.getController("right"+"TeamCountryTextfield");
  if(theEvent.isFrom(tf))
  {
    Textlabel tl = (Textlabel)dashboard.cp5.getController("right"+"TeamCountryLabel");
    textSize(dashboard.rightTeamColumn.countryHeight);
    tl.setPosition(dashboard.rightTeamColumn.x+dashboard.rightTeamColumn.width/2 - (int)textWidth(tf.getText())/2-(5),dashboard.rightTeamColumn.y+dashboard.rightTeamColumn.nameHeight+(dashboard.rightTeamColumn.distanceBetween)+(dashboard.rightTeamColumn.height/6));
    tl.setText(tf.getText());
  }
  tf = (Textfield)cp5.getController("TimerTextfield");
  if(theEvent.isFrom(tf))
  {
    timerEdit.periodTime = timerEdit.StringToTimerEdit(tf.getText(),timerEdit.periodTime);
    timerEdit.timerTextfield.setText(timerEdit.TimerToStringEdit(timerEdit.periodTime));
    
    String dashboardTimeString = timerEdit.TimerToString(timerEdit.periodTime);
    dashboard.timerLabel.setText(dashboardTimeString);
    dashboard.SetTimerLabelPosition(dashboardTimeString);
  }
}
