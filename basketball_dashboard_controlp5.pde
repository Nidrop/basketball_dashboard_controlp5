import processing.serial.*;
import controlP5.*;
//+++
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.io.StringWriter;
import java.io.PrintWriter;
//---

PFont columnsLabelFont;

DashboardApplet dashboard;

ControlP5 cp5;

int elapsedTime = 0, elapsedTimeCorrection = 0, deltaTime = 100;

SerialButtons serialButtons;
SerialHandler serialHandler;
AutosaveButton autosaveButton;

PApplet dashboardEdit = this;

void settings() {
  size(1080,512);
}

void setup()
{ 
  frameRate(30);
  
  columnsLabelFont = createFont("DejaVu Sans",25);
  
  dashboard = new DashboardApplet();
  cp5 = new ControlP5(this);
  surface.setTitle("Судейская система Баскетбол");
  //surface.setResizable(true);
  
  buttonsFont = createFont("DejaVu Sans",13);
  autosaveButton = new AutosaveButton(cp5,
                                      playerBoxWidth+1,20+5,centerBoxWidth-1, 20);
  
  initDashboardEdit();
  serialButtons = new SerialButtons(cp5,
                                    playerBoxWidth+1,0,centerBoxWidth-1,20*4,
                                    60);
  serialHandler = new SerialHandler();
  
  tryReadSession();
  calculateTeamsScore();
  
  /*
  String[] s = PFont.list();
  for(int i=0;i<PFont.list().length;i++){
    println(s[i]);
  }
  */

}

//void pre() {
//  if (dashboardEditWindowWidth != width || dashboardEditWindowHeight != height) {
//    // Sketch window has resized
//    dashboardEditWindowWidth = width;
//    dashboardEditWindowHeight = height;
//  }
//}

void draw()
{
  //debug crash
  try{
    background(color(40,40,40));
    int newElapsedTime = millis();
    int elapsedTimeDiff = newElapsedTime - elapsedTime;
    if(elapsedTimeDiff >= (deltaTime - elapsedTimeCorrection)){
      elapsedTime = newElapsedTime;
      elapsedTimeCorrection = elapsedTimeDiff - (deltaTime - elapsedTimeCorrection);
  
      drawDashboardEdit();
      serialHandler.Recieve(timerEdit);
      serialHandler.SetStates(timerEdit);
      serialHandler.Send();
      
      if(autosaveButton.enabled){
        autosaveButton.elapsed += elapsedTimeDiff;
        if(autosaveButton.elapsed >= autosaveButton.duration){
          autosaveButton.elapsed = 0;
          saveSession();
        }
      }
    }
    
    //lines
    stroke(255,255,255); 
    line(playerNumberWidth,0,playerNumberWidth,dashboardEditWindowHeight);
    line(playerNumberWidth+playerNameWidth,0,playerNumberWidth+playerNameWidth,dashboardEditWindowHeight);
    line(playerBoxWidth-playerScoreWidth,0,playerBoxWidth-playerScoreWidth,dashboardEditWindowHeight);
    line(playerBoxWidth,0,playerBoxWidth,dashboardEditWindowHeight);
    
    line(dashboardEditWindowWidth - playerBoxWidth,0,dashboardEditWindowWidth - playerBoxWidth,dashboardEditWindowHeight);
    line(dashboardEditWindowWidth - playerBoxWidth+playerNumberWidth,0,dashboardEditWindowWidth - playerBoxWidth+playerNumberWidth,dashboardEditWindowHeight);
    line(dashboardEditWindowWidth - playerBoxWidth+playerNumberWidth+playerNameWidth,0,dashboardEditWindowWidth - playerBoxWidth+playerNumberWidth+playerNameWidth,dashboardEditWindowHeight);
    line(dashboardEditWindowWidth - playerScoreWidth,0,dashboardEditWindowWidth - playerScoreWidth,dashboardEditWindowHeight);
    
    /*
    line(playerBoxWidth+teamBoxWidth,0,playerBoxWidth+teamBoxWidth,dashboardEditWindowHeight);
    line(dashboardEditWindowWidth - playerBoxWidth - teamBoxWidth,0,dashboardEditWindowWidth - playerBoxWidth - teamBoxWidth,dashboardEditWindowHeight);
    line(dashboardEditWindowWidth/2,0,dashboardEditWindowWidth/2,dashboardEditWindowHeight);
    */
  }
  catch(Exception e){
    println("Exception catched! Saving crash log");
    saveCrashLog(e);
    println("Crash log is saved");
    exit();
  }
}
