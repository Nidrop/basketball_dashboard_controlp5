class SerialButtons {
  ControlP5 cp;
  int x, y, width, height, buttonsWidth;
  
  Button refreshSerial, startSerial;
  ScrollableList serialDropdown;
  
  
  
  SerialButtons(ControlP5 cp,
                int x, int y, int width, int height,
                int buttonsWidth)
  {
    this.cp = cp;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.buttonsWidth = buttonsWidth;
    
    serialDropdown = cp.addScrollableList("SerialDropdown")
                        .setCaptionLabel("порт")
                        .setPosition(x, y)
                        .setSize(width - buttonsWidth*2 - (4), height)
                        .setBarHeight(height/4)
                        .setItemHeight(height/4)
                        .setOpen(false)
                        .setFont(buttonsFont)
                        .setItems(Serial.list());
     
    refreshSerial = cp.addButton("RefreshSerial")
                       .setCaptionLabel("обн")
                       .setPosition(x+width-buttonsWidth*2 - (2),y)
                       .setSize(buttonsWidth,height/4)
                       .setValue(0)
                       .setFont(buttonsFont)
                       .addCallback(new CallbackListener(){
                          public void controlEvent(CallbackEvent theEvent) {
                            if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
                              serialButtons.serialDropdown.setItems(Serial.list());
                            }
                          }
                        });

    startSerial = cp.addButton("StartSerial")
                     .setCaptionLabel("подкл")
                     .setPosition(x+width-buttonsWidth,y)
                     .setSize(buttonsWidth,height/4)
                     .setValue(0)
                     .setFont(buttonsFont)
                     .addCallback(new CallbackListener(){
                        public void controlEvent(CallbackEvent theEvent) {
                          if (theEvent.getAction()==ControlP5.ACTION_PRESSED) {
                             ScrollableList sd = cp5.get(ScrollableList.class, "SerialDropdown");
                             int n = (int)sd.getValue();
                             String port = (String)sd.getItem(n).get("text");
                             //println(port);
                             try {
                               serialHandler.OpenOrClose(port);
                               
                               if(serialButtons.startSerial.getCaptionLabel().getText() == "подкл"){
                                 serialButtons.startSerial.setCaptionLabel("откл");
                               }
                               else{
                                 serialButtons.startSerial.setCaptionLabel("подкл");
                               }
                             }
                             catch(Exception e){
                               println(e.getMessage());
                             }
                          }
                        }
                      });
  }
}

//class SerialConstants {
 static final int STATE_ON =                   0b00000001;
 static final int STATE_TIMER_MODE_PERIOD =    0b00000010; //period=1, timeout=0
 static final int STATE_TIMER_PAUSE =          0b00000100;
 static final int STATE_ATTACK_ON =            0b00001000;
 static final int STATE_ATTACK_PAUSE =         0b00010000;
 static final int STATE_ONE_SEC_AFTER_PERIOD = 0b00100000;
 static final int STATE_ONE_SEC_AFTER_ATTACK = 0b01000000;
 static final int STATE_ONE_SEC_AFTER_TIMEOUT =0b10000000;
 
 /*
 static final byte STATE_BUTTON_ATTACK_14 =     (byte) 0b00100000;
 static final byte STATE_BUTTON_ATTACK_24 =     (byte) 0b01000000;
 static final byte STATE_BUTTON_ATTACK_PAUSE =  (byte) 0b01100000;
 static final byte STATE_BUTTON_ATTACK_OFF =    (byte) 0b10000000;
 static final byte STATE_BUTTON_TONE =          (byte) 0b10100000;
 static final byte STATE_BUTTON_TIMER_PAUSE =   (byte) 0b11000000;
 */
//}

class SerialHandler {
  ByteBuffer bb = ByteBuffer.allocate(5);
  //ByteBuffer bb = ByteBuffer.allocate(9);
  Serial serial = null;
  
  boolean isSerialOpened = false;
  
  int state = 0;
  int sendTimer = 0;
  
  SerialHandler(){
   bb.order(ByteOrder.LITTLE_ENDIAN);
   
   state = STATE_TIMER_MODE_PERIOD |
           STATE_TIMER_PAUSE;
  }
  
  void OpenOrClose(String port){
    if(serial != null)
    {
      state = 0; //выключить передачу
      serial.clear();
      serial.stop();
      serial = null;
    } else {
      serial = new Serial(dashboardEdit, port, 9600);
      state = state | STATE_ON;  //включить передачу
    }
  }
  
  void Recieve(TimerEdit te){
    if(serial != null){
      if(serial.available() > 0){
        int newState = serial.read();
        
        boolean pauseChanged = (newState & STATE_TIMER_PAUSE) != (state & STATE_TIMER_PAUSE);
        boolean periodChanged = (newState & STATE_TIMER_MODE_PERIOD) != (state & STATE_TIMER_MODE_PERIOD);
        
        if(pauseChanged){
          //пауза периода/таймера
          if((newState & STATE_TIMER_PAUSE) == STATE_TIMER_PAUSE)
          {
            te.isPaused = true;
            te.timerPause.setCaptionLabel("старт");
            te.timerTextfield.setLock(false);
          }
          else
          {
            if(te.periodTime > 0){
              te.isPeriod = true;
              
              dashboard.timeoutTimerLabel.setVisible(false);
              dashboard.timeoutTextLabel.setVisible(false);
              
              te.isPaused = false;
              te.timerPause.setCaptionLabel("пауза");
              te.timerTextfield.setLock(true);
            }
          }
        }
        
        if(periodChanged){
          //смена таймаут/период
          if((newState & STATE_TIMER_MODE_PERIOD) == STATE_TIMER_MODE_PERIOD)
          {
            te.isPeriod = true;
              
            dashboard.timeoutTimerLabel.setVisible(false);
            dashboard.timeoutTextLabel.setVisible(false);
          }
          else
          {
            te.isPeriod = false;
            //te.timeoutTime = 1000;
            te.timeoutTime = 1000 * 60;
              
            dashboard.timeoutTimerLabel.setVisible(true);
            dashboard.timeoutTextLabel.setVisible(true);
              
            te.isPaused = true;
            te.timerPause.setCaptionLabel("старт");
            te.timerTextfield.setLock(false);
          }
        }
      }  
    }
  }
  
  void SetStates(TimerEdit te){
    if(te.isPeriod){
      state = state | STATE_TIMER_MODE_PERIOD;
      sendTimer = te.periodTime;
    }
    else{
      state = state & (~STATE_TIMER_MODE_PERIOD);
      sendTimer = te.timeoutTime;
    }
    
    if(te.isPaused){
      state = state | STATE_TIMER_PAUSE;
    }
    else{
      state = state & (~STATE_TIMER_PAUSE);
    }
    
    if(te.isFirstSecondAfterTimeout){
      state = state | STATE_ONE_SEC_AFTER_TIMEOUT;
    }
    else{
      state = state & (~STATE_ONE_SEC_AFTER_TIMEOUT);
    }
    
    if(te.isFirstSecondAfterPeriod){
      state = state | STATE_ONE_SEC_AFTER_PERIOD;
    }
    else{
      state = state & (~STATE_ONE_SEC_AFTER_PERIOD);
    }
  }
  
  void Send(){
    if((state & STATE_ON) == STATE_ON) //посылаем, если включено
    {
      bb.put((byte)state);
      bb.putInt(sendTimer);
      //bb.putInt(sendTimer);
      serial.write(bb.array());
      bb.rewind();
      //println((byte)state+"+"+sendTimer);
    }
  }
}
