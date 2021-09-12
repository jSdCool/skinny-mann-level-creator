void settings(){
  size(1280,720,P3D);
}

void setup(){
loadJSONArray("data/colors.json");
 frameRate(60);
  surface.setTitle("skinny mann level creator");
  scr2 =new ColorSelectorScreen();
  colors=loadJSONArray("data/colors.json");
  thread("thrdCalc2");
    coin3D=loadShape("data\\modles\\coin\\tinker.obj");
    coin3D.scale(3);
}
boolean startup=true,editing_level=true,player1_moving_right=false,player1_moving_left=false,dev_mode=false,player1_jumping=false,loading=false,newLevel=false,simulating=false,entering_file_path=false,coursor=false,level_complete=false,dead=false,entering_name=false,cam_left=false,cam_right=false,drawing=false,draw=false,extra=false,ground=false,check_point=false,goal=false,deleteing=false,delete=false,moving_player=false,grid_mode=false,holo_gram=false,editingStage=false,levelOverview=false,newFile=false,drawCoins=false,drawingPortal=false,drawingPortal2=false,drawingPortal3=false,E_pressed=false,saveColors=false,sloap=false,loopThread2=true,cam_up=false,cam_down=false,holoTriangle=false,dethPlane=false,setPlayerPosTo=false,e3DMode=false,WPressed=false,SPressed=false,draw3DSwitch1=false,draw3DSwitch2=false,checkpointIn3DStage=false;
String file_path,new_name="my_level",GAME_version="0.3.0_ALFA",EDITOR_version="0.0.1.4_BETA",rootPath="",coursorr="",newFileName="",newLevelType="2D",stageType="";
//int player1 []={20,700,1,0,1,0};
Player player1 =new Player(20,699,1,"red");
int camPos=0,camPosY=0,death_cool_down,start_down,eadgeScroleDist=100,respawnX=20,respawnY=700,spdelay=0,Color=0,RedPos=0,BluePos=0,GreenPos=0,RC=0,GC=0,BC=0,grid_size=10,filesScrole=0,overviewSelection=-1,portalIndex1,stageIndex,preSI,respawnStage,setPlayerPosX,setPlayerPosY,setPlayerPosZ,startingDepth=0,totalDepth=300,respawnZ=50,coinRotation=0,coinCount=0,gmillis=0,eadgeScroleDistV=100;
int buttonMin=40,buttonMax=980,coinsIndex,triangleMode=0;
JSONArray level_terain,mainIndex,coins,colors;
JSONObject portalStage1,portalStage2;
float downX,downY,upX,upY,Scale=1;
ColorSelectorScreen scr2 ;
PShape coin3D;

void draw(){
  
  if(frameCount%20==0){
   coursor=false; 
   coursorr="";
  }
  if(frameCount%40==0){
   coursor=true; 
   coursorr="|";
  }
  
  if(saveColors){
   saveJSONArray(colors,"/data/colors.json");
    saveColors=false;
  }
  
  if(startup){
    background(#48EDD8);
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(200,300,200,80);
    rect(800,300,200,80);
    fill(0);
    textSize(80);
    textAlign(BOTTOM,LEFT);
    text("new",210,370);
    text("load",810,370);
    fill(255);
    textSize(10);
    text("game ver: "+GAME_version+ "  editor ver: "+EDITOR_version,0,718);

  }
  if(loading){
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter level name",40,100);
    if(rootPath!=null){
      if(entering_file_path&&coursor){
        text(rootPath+"|",40,150);
    }else{
        text(rootPath,40,150);
    }}else if(entering_file_path&&coursor){
        text("|",40,150);
    }
    stroke(0);
    strokeWeight(1);
    line(40,152,1200,152);
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(40,400,200,40);
    fill(0);
    textSize(40);
    text("load",50,435);
  }
  if(newLevel){
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter level name",40,100);
    if(new_name!=null){
      if(entering_name&&coursor){
        text(new_name+"|",40,150);
    }else{
        text(new_name,40,150);
    }}else if(entering_name&&coursor){
        text("|",40,150);
    }
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(40,400,200,40);
    fill(0);
    textSize(40);
    text("start",50,435);
    stroke(0);
    strokeWeight(1);
    line(40,152,800,152);
  }
  
  
  if(editingStage){
    background(7646207);
    if(!simulating){
      if(cam_left&&camPos>0){
        camPos-=4;
      }
      if(cam_right){
        camPos+=4;
      }
      if(cam_down&&camPosY>0){
        camPosY-=4;
      }
      if(cam_up){
        camPosY+=4;
      }
    }
    
        stageLevelDraw();
        stageEditGUI();
        
       // playerPhysics();
 }
 
 if(levelOverview){
   background(#0092FF);
   fill(#7CC7FF);
   stroke(#7CC7FF);
   strokeWeight(0);
   JSONObject infos;
   if(overviewSelection!=-1){
    rect(0,overviewSelection*60+80,1280,60);
    infos=mainIndex.getJSONObject(overviewSelection+1);
    if(infos.getString("type").equals("stage")){
      edditStage.draw();
      fill(255,255,0);
      strokeWeight(1);
      quad(1155,37,1129,54,1114,39,1140,22);
      fill(#E5B178);
      triangle(1129,54,1114,39,1109,53);
      setMainStage.draw();
      fill(255,0,0);
      quad(1030,16,1010,40,1030,66,1050,40);
      if(setMainStage.isMouseOver()){
       fill(200);
       rect(mouseX-4,mouseY-18,135,20);
        fill(0);
       textSize(15);
       textAlign(LEFT,BOTTOM);
       text("set as main stage",mouseX,mouseY);
      }
    }
    if(infos.getString("type").equals("3Dstage")){
      edditStage.draw();
      fill(255,255,0);
      strokeWeight(1);
      quad(1155,37,1129,54,1114,39,1140,22);
      fill(#E5B178);
      triangle(1129,54,1114,39,1109,53);
    }
   }
   textAlign(LEFT, BOTTOM);
   stroke(0);
   strokeWeight(2);
   line(0,80,1280,80);
   fill(0);
   textSize(30);
   if(mainIndex==null){
    mainIndex=loadJSONArray(rootPath+"\\index.json"); 
   }

   for(int i=1;
   i<11&&i+filesScrole<mainIndex.size();
   i++){
     
     JSONObject indexs=mainIndex.getJSONObject(i);
     fill(0);
     String displayName=indexs.getString("name"),type=indexs.getString("type");
     text(displayName,80,130+60*(i-1));
     if(type.equals("coins")){
       drawCoin(40,110+60*(i-1),4);
       coinsIndex=i;
       coins=loadJSONArray(rootPath+mainIndex.getJSONObject(i).getString("location"));
     }
     if(type.equals("stage")){
      drawWorldSymbol(20,90+60*(i-1)); 
     }
   }
   textAlign(CENTER, CENTER);
   newStage.draw();
   fill(0);
   textSize(90);
   text("+",1230,25);
   textAlign(LEFT, BOTTOM);
   JSONObject m=mainIndex.getJSONObject(0);
   respawnX=m.getInt("spawnX");
   respawnY=m.getInt("spawnY");
   respawnStage=m.getInt("mainStage");
   
 }
   if(newFile){
     background(#0092FF);
     stroke(0);
     strokeWeight(2);
     line(100,450,1200,450);
     if(newLevelType.equals("2D")){
       new2DStage.setColor(#BB48ED,#51DFFA);
       new3DStage.setColor(#BB48ED,#4857ED);
     }else if(newLevelType.equals("3D")){
       new3DStage.setColor(#BB48ED,#51DFFA);
       new2DStage.setColor(#BB48ED,#4857ED);
     }
     println(newLevelType);
     new2DStage.draw();
     new3DStage.draw();
     newFileCreate.draw();
     newFileBack.draw();
     fill(0);
     textSize(70);
     textAlign(LEFT, BOTTOM);
     text(newFileName+coursorr,100,445);
   }
   
   if(drawingPortal2){
     background(#0092FF);
   fill(#7CC7FF);
   stroke(#7CC7FF);
   strokeWeight(0);
   JSONObject infos;
   if(overviewSelection!=-1){
    rect(0,overviewSelection*60+80,1280,60);
    infos=mainIndex.getJSONObject(overviewSelection+1);
    if(infos.getString("type").equals("stage")||infos.getString("type").equals("3Dstage")){
     selectStage.draw();
      textAlign(LEFT, BOTTOM);
      stroke(0,255,0);
      strokeWeight(7);
      line(1212,44,1224,55);
      line(1224,55,1253,29);
    }
   }
   textAlign(LEFT, BOTTOM);
   stroke(0);
   strokeWeight(2);
   line(0,80,1280,80);
   fill(0);
   textSize(30);
   for(int i=1;i<11&&i+filesScrole<mainIndex.size();i++){
     JSONObject indexs=mainIndex.getJSONObject(i);
     fill(0);
     String displayName=indexs.getString("name"),type=indexs.getString("type");
     text(displayName,80,130+60*(i-1));
     if(type.equals("coins")){
       drawCoin(40,110+60*(i-1),4);
       coinsIndex=i;
       coins=loadJSONArray(rootPath+mainIndex.getJSONObject(i).getString("location"));
       
     }
     if(type.equals("stage")){
      drawWorldSymbol(20,90+60*(i-1)); 
      
     }
   }
   textAlign(CENTER, CENTER);
   
   fill(0);
   textSize(90);
   text("select destenation stage",640,30);
   textAlign(LEFT, BOTTOM);
   
     
   }

  engageHUDPosition();
  fill(255);
  textSize(10);
  text("fps: "+ frameRate,1200,10);
  text("mspc: "+mspc,1200,25);
  if(millis()<gmillis){
    glitchEffect();
  }
  
  disEngageHUDPosition();
  
  
}


void mouseClicked(){
  
  if(mouseButton==LEFT){
  println(mouseX+" "+mouseY);
    if(startup){
       if(mouseX >=200 && mouseX <= 400 && mouseY >= 300 && mouseY <= 380){
         startup=false;
         newLevel=true;
       }
       if(mouseX >=800 && mouseX <= 1000 && mouseY >= 300 && mouseY <= 380){
         startup=false;
         loading=true;
       }
    }
    if(loading){
      if(mouseX >=40 && mouseX <= 1200 && mouseY >= 100 && mouseY <= 150){
         entering_file_path=true;
       }
       if(mouseX >=40 && mouseX <= 240 && mouseY >= 400 && mouseY <= 440){
         try{
           mainIndex=loadJSONArray(rootPath+"\\index.json");
         entering_file_path=false;
         loading=false;
         levelOverview=true;
         }
         catch(Throwable e){
           
         }
         return;
       }
    }
    if(newLevel){
      if(mouseX >=40 && mouseX <= 1200 && mouseY >= 100 && mouseY <= 150){
         entering_name=true;
       }//rect(40,400,200,40);
       if(mouseX >=40 && mouseX <= 240 && mouseY >= 400 && mouseY <= 440){
         entering_name=false;
         newLevel=false;
         rootPath=new_name;
         JSONArray mainIndex=new JSONArray();
        JSONObject terain = new JSONObject();
        terain.setInt("level_id", (int)(Math.random()*1000000000%999999999));
        terain.setString("name", new_name);
        terain.setString("game version",GAME_version);
        terain.setFloat("spawnX", 20);
        terain.setFloat("spawnY", 700);  
        terain.setFloat("spawn pointX", 20);
        terain.setFloat("spawn pointY", 700);
        terain.setInt("mainStage",-1);
        terain.setInt("coins",1);
        mainIndex.setJSONObject(0,terain);
        terain = new JSONObject();
        terain.setString("type","coins");
        terain.setString("location","\\coins.json");
        terain.setString("name","coins");
        mainIndex.setJSONObject(1,terain);
        saveJSONArray(mainIndex, rootPath+"\\index.json");
        coins=new JSONArray();
        terain = new JSONObject();
        terain.setString("type","coins");
        coins.setJSONObject(0,terain);
        saveJSONArray(coins, rootPath+"\\coins.json");
        
        levelOverview=true;
        mainIndex=loadJSONArray(rootPath+"\\index.json");
        return;
       }
    }
    if(editingStage){
      if(stageType.equals("stage")){
      if(mouseX >=40 && mouseX <= 270 && mouseY >= 40 && mouseY <= 90){
        if(mouseX >=40 && mouseX <= 90 && mouseY >= 40 && mouseY <= 90){
          extra=true;
          if(extra&&simulating){
             simulating=false; 
             extra=false;
          }
          if(extra&&!simulating){
             simulating=true; 
             extra=false;
          }
        }
      }
      
      if(mouseX >=100 && mouseX <= 140 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        ground=true;
        
      }
      if(mouseX >=160 && mouseX <= 190 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        check_point=true;
      }
      if(mouseX >=220 && mouseX <= 270 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        goal=true;

      }
      if(mouseX >=280 && mouseX <= 330 && mouseY >= 40 && mouseY <= 90){
turnThingsOff();
        deleteing=true;
      }
      if(mouseX >=340 && mouseX <= 390 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        moving_player=true;
      }
      if(mouseX >=400 && mouseX <= 440 && mouseY >= 40 && mouseY <= 90){
        extra=true;
        if(extra&&grid_mode){
          grid_mode=false;
          extra=false;
        }
        if(extra&&!grid_mode){
          grid_mode=true;
          extra=false;
        }
      }
      
      if(mouseX >=460 && mouseX <= 500 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        holo_gram=true;
      }
      
      if(exitStageEdit.isMouseOver()){
         turnThingsOff();
        levelOverview=true;
        editingStage=false;
       
      }
      if(draw_coin.isMouseOver()){
        turnThingsOff();
        drawCoins=true;
      }
      if(draw_portal.isMouseOver()){
        turnThingsOff();
        drawingPortal=true;
      }
      if(draw_sloap.isMouseOver()){
        turnThingsOff();
        sloap=true;
      }
      if(draw_holoTriangle.isMouseOver()){
        turnThingsOff();
        holoTriangle=true;
      }
      if(draw_dethPlane.isMouseOver()){
        turnThingsOff();
        dethPlane=true;
      }
      }//end of stage type = stage
      
      if(stageType.equals("3Dstage")){
      
      if(!e3DMode){
        if(mouseX >=40 && mouseX <= 270 && mouseY >= 40 && mouseY <= 90){//pause / play button
        if(mouseX >=40 && mouseX <= 90 && mouseY >= 40 && mouseY <= 90){
          extra=true;
          if(extra&&simulating){
             simulating=false; 
             extra=false;
          }
          if(extra&&!simulating){
             simulating=true; 
             extra=false;
          }
        }
      }
      
      if(mouseX >=100 && mouseX <= 140 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        ground=true;
        
      }
      
      if(mouseX >=280 && mouseX <= 330 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        deleteing=true;
      }
      
      if(mouseX >=400 && mouseX <= 440 && mouseY >= 40 && mouseY <= 90){
        extra=true;
        if(extra&&grid_mode){
          grid_mode=false;
          extra=false;
        }
        if(extra&&!grid_mode){
          grid_mode=true;
          extra=false;
        }
      }
      
      if(exitStageEdit.isMouseOver()){
         turnThingsOff();
        levelOverview=true;
        editingStage=false;
       
      }
      
      if(toggle3DMode.isMouseOver()){
        e3DMode=true;
        return;
      }
      if(switch3D1.isMouseOver()){
        turnThingsOff();
        draw3DSwitch1=true;
      }
      if(switch3D2.isMouseOver()){
        turnThingsOff();
        draw3DSwitch2=true;
      }
      
      if(mouseX >=160 && mouseX <= 190 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        check_point=true;
      }
      if(draw_portal.isMouseOver()){
        turnThingsOff();
        drawingPortal=true;
      }
      if(mouseX >=460 && mouseX <= 500 && mouseY >= 40 && mouseY <= 90){
        turnThingsOff();
        holo_gram=true;
      }
      if(draw_coin.isMouseOver()){
        turnThingsOff();
        drawCoins=true;
      }
      
      }//end of 3D mode not active
      else{
        if(toggle3DMode.isMouseOver()){
        e3DMode=false;
      }
      }//end of 3D mode is on 
      }//end of stage type = 3Dstage 
      
      
      
    }//end of eddit stage 
    
    if(check_point){
      if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        draw=true;
      }
    }
    if(goal){
      if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        draw=true;
      }
    }
    if(deleteing){
      if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        delete=true;
      }
    }
    if(moving_player){
      if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        player1.setX(mouseX+camPos);
        player1.setY(mouseY-camPosY);
      }
    }
    if(drawCoins){
      if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        coins=loadJSONArray(rootPath+mainIndex.getJSONObject(coinsIndex).getString("location"));
        level_terain=loadJSONArray(file_path);
        int cid=coins.size();
        JSONObject terain = new JSONObject();
        terain.setInt("x", (int)mouseX+camPos);
        terain.setString("type", "coin");
        terain.setInt("y", (int)mouseY-camPosY);
        terain.setInt("z", startingDepth);
        terain.setInt("coin id",cid);
        level_terain.setJSONObject(level_terain.size(),terain);
        saveJSONArray(level_terain, file_path);
        JSONObject co=new JSONObject();
        co.setBoolean("collected",false);
        coins.setJSONObject(coins.size(),co);
        saveJSONArray(coins,rootPath+mainIndex.getJSONObject(coinsIndex).getString("location"));
      }
    }
    if(drawingPortal){
      if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        portalStage1=new JSONObject();
        portalStage2=new JSONObject();
        portalStage1.setString("type","interdimentional Portal");
        portalStage2.setString("type","interdimentional Portal");
        portalStage1.setInt("x",mouseX+camPos);
        portalStage1.setInt("y",mouseY-camPosY);
        portalStage2.setInt("linkX",mouseX+camPos);
        portalStage2.setInt("linkY",mouseY-camPosY);
        if(stageType.equals("3Dstage")){
          portalStage1.setInt("z",startingDepth);
          portalStage2.setInt("linkZ",startingDepth);
        }
        portalStage2.setInt("link Index",stageIndex);
        drawingPortal=false;
        drawingPortal2=true;
        editingStage=false;
        preSI=stageIndex;
        
      }
    }
    if(drawingPortal3){
        if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        portalStage2.setInt("x",mouseX+camPos);
        portalStage2.setInt("y",mouseY-camPosY);
        portalStage1.setInt("linkX",mouseX+camPos);
        portalStage1.setInt("linkY",mouseY-camPosY);
        portalStage1.setInt("link Index",stageIndex);
        if(stageType.equals("3Dstage")){
          portalStage2.setInt("z",startingDepth);
          portalStage1.setInt("linkZ",startingDepth);
        }
        level_terain.setJSONObject(level_terain.size(),portalStage2);
        saveJSONArray(level_terain, file_path);
        JSONArray r2=loadJSONArray(rootPath+mainIndex.getJSONObject(preSI).getString("location"));
        r2.setJSONObject(r2.size(),portalStage1);
        saveJSONArray(r2,rootPath+mainIndex.getJSONObject(preSI).getString("location"));
        portalStage2=null;
        portalStage1=null;
        drawingPortal3=false;
        
      }
     }
     if(draw3DSwitch1){
       if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        draw=true;
      }
     }
     if(draw3DSwitch2){
       if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
      }else{
        draw=true;
      }
     }
    
    
    
    if(levelOverview){
     if(newStage.isMouseOver()){
       levelOverview=false;
       newFile=true;
       newFileName="";
     }
      if(mouseY>80){
        overviewSelection=(mouseY-80)/60;
        if(overviewSelection>=mainIndex.size()-1){
        overviewSelection=-1;
      }
      }
       JSONObject infos;
      if(overviewSelection!=-1){
        infos=mainIndex.getJSONObject(overviewSelection+1);
        if(infos.getString("type").equals("stage")){
          if(edditStage.isMouseOver()){
            file_path=rootPath+infos.getString("location");
            editingStage=true;
            levelOverview=false;
            stageIndex=overviewSelection+1;
            respawnStage=stageIndex;
          }
        
          if(setMainStage.isMouseOver()){
           infos = mainIndex.getJSONObject(0); 
           infos.setInt("mainStage",overviewSelection+1);
           mainIndex.setJSONObject(0,infos);
           saveJSONArray(mainIndex,rootPath+"\\index.json");
           background(0);
           return;
          }
        }
        if(infos.getString("type").equals("3Dstage")){
          if(edditStage.isMouseOver()){
            file_path=rootPath+infos.getString("location");
            editingStage=true;
            levelOverview=false;
            stageIndex=overviewSelection+1;
            respawnStage=stageIndex;
          }
        }
        
      }
      
      
    }
    
    if(newFile){
     if(newFileBack.isMouseOver()){
       levelOverview=true;
       newFile=false;
     }
     
     if(newFileCreate.isMouseOver()){
      if(newFileName.equals("")){
       return; 
      }
      level_terain =new JSONArray();
      JSONObject ob= new JSONObject();
      stageIndex=mainIndex.size();
      respawnStage=stageIndex;
      if(newLevelType.equals("2D")){
      ob.setString("type","stage");
      }
      if(newLevelType.equals("3D")){
      ob.setString("type","3Dstage");  
      }
      ob.setString("name",newFileName);
      level_terain.setJSONObject(0,ob);
      saveJSONArray(level_terain,rootPath+"\\"+newFileName+".json");
      mainIndex=loadJSONArray(rootPath+"\\index.json");
      ob= new JSONObject();
      ob.setString("name",newFileName);
      
      if(newLevelType.equals("2D")){
      ob.setString("type","stage");
      }
      if(newLevelType.equals("3D")){
      ob.setString("type","3Dstage");  
      }
      
      ob.setString("location","\\"+newFileName+".json");
      mainIndex.setJSONObject(mainIndex.size(),ob);
      saveJSONArray(mainIndex,rootPath+"\\index.json");
      file_path=rootPath+"\\"+newFileName+".json";
      editingStage=true;
      newFile=false;
     }
     
     if(new3DStage.isMouseOver()){
       newLevelType="3D";
     }
     if(new2DStage.isMouseOver()){
       newLevelType="2D";
     }
    }
    if(drawingPortal2){
     
      if(mouseY>80){
        overviewSelection=(mouseY-80)/60;
        if(overviewSelection>=mainIndex.size()-1){
        overviewSelection=-1;
      }
      }
       JSONObject infos;
      if(overviewSelection!=-1){
        infos=mainIndex.getJSONObject(overviewSelection+1);
        if(infos.getString("type").equals("stage")||infos.getString("type").equals("3Dstage")){
          //if(edditStage.isMouseOver()){
          //  file_path=rootPath+infos.getString("location");
          //  editingStage=true;
          //  levelOverview=false;
          //  stageIndex=overviewSelection+1;
          //}
          if(selectStage.isMouseOver()){
            editingStage=true;
            levelOverview=false;
            file_path=rootPath+infos.getString("location");
            drawingPortal2=false;
            drawingPortal3=true;
            camPos=0;
            stageIndex=overviewSelection+1;
          }
        }
      }
      
       
    }
    
  }
}

void keyPressed(){
  if (key == ESC) {
    key = 0;  //clear the key so it doesnt close the program
  }
  if(simulating){
  if(keyCode==65){
    player1_moving_left=true;
  }
  if(keyCode==68){
    player1_moving_right=true;
  }
  if(keyCode==32){
    player1_jumping=true;
  }
  if(key=='e'||key=='E'){
   E_pressed=true; 
  }
  if(e3DMode){
  if(keyCode==87){//w
    WPressed=true;
  }
  if(keyCode==83){//s
    SPressed=true;
  }
  
  }//end of 3d mode
  
  }
  if(!simulating){
  if(keyCode==37){
    cam_left=true;
  }
  if(keyCode==39){
    cam_right=true;
  }
  if(keyCode==38){
    cam_up=true;
  }
  if(keyCode==40){
    cam_down=true;
  }
  
  
  
}
 if(key=='q'){
  println(player1.x+" "+player1.y+" "+player1.z/*+" "+player1.getY()*/); 
 }

 
 
 if(editingStage){
    if(key=='r'||key=='R'){
     triangleMode++;
     if(triangleMode==4)
     triangleMode=0;
    }
  }
  
  if(entering_file_path){
    if(keyCode>=48&&keyCode<=57||keyCode==46||keyCode==32||(keyCode>=65&&keyCode<=90)||keyCode==59||keyCode==92||keyCode==45){
   
   if(rootPath==null){
     rootPath=key+"";
 }else{
   rootPath+=key;
 }
 
 }
 if(keyCode==8){
   if(rootPath==null){}
   else{
     if(rootPath.length()==1){
      rootPath=null; 
     }else{
    rootPath=rootPath.substring(0,rootPath.length()-1); 
     } 
   }
 }
  }
  
  if(entering_name){
    if(keyCode>=48&&keyCode<=57||keyCode==46||keyCode==32||(keyCode>=65&&keyCode<=90)||keyCode==59||keyCode==92||keyCode==45){
   
   if(new_name==null){
     new_name=key+"";
 }else{
   new_name+=key;
 }
 
 }
 if(keyCode==8){
   if(new_name==null){}
   else{
     if(new_name.length()==1){
      new_name=null; 
     }else{
    new_name=new_name.substring(0,new_name.length()-1); 
     } 
   }
 }
  }
  if(newFile){
  newFileName=getInput(newFileName,0);
}
//System.out.println(keyCode);
}

void keyReleased(){
  if(simulating){
    if(keyCode==65){
      player1_moving_left=false;
    }
    if(keyCode==68){
      player1_moving_right=false;
    }
    if(keyCode==32){
    player1_jumping=false;
  }
  if(e3DMode){
  if(keyCode==87){//w
    WPressed=false;
  }
  if(keyCode==83){//s
    SPressed=false;
  }
  }//end of 3d mode
  
  }
  if(key=='e'||key=='E'){
   E_pressed=false; 
  }
  if(!simulating){
  if(keyCode==37){
    cam_left=false;
  }
  if(keyCode==39){
    cam_right=false;
  }
  if(keyCode==38){
    cam_up=false;
  }
  if(keyCode==40){
    cam_down=false;
  }
  }

}

void mousePressed(){
  if(mouseButton==LEFT){
 if(editingStage&&(ground||holo_gram||sloap||holoTriangle||dethPlane)){
   if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
    return; 
   }
   if(mouseX >=35 && mouseX <= 280 && mouseY >= 95 && mouseY <= 150){
    return; 
   }else{
   downX=mouseX;
   downY=mouseY;
   drawing=true;
 }}

 }
}

void mouseReleased(){
  if(mouseButton==LEFT){
  if(editingStage&&(ground||holo_gram||sloap||holoTriangle||dethPlane)&&drawing){
    if(mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90){
    return; 
   }
   if(mouseX >=35 && mouseX <= 280 && mouseY >= 95 && mouseY <= 150){
    return; 
   }else{
    upX=mouseX;
    upY=mouseY;
    drawing=false;
    draw=true;
  }}
}
}

void mouseDragged(){
  if(mouseButton==LEFT){
  if(editingStage&&(ground||holo_gram)){
     if(mouseX>=RedPos+35&&mouseX<=RedPos+55&& mouseY>=98&&mouseY<=112&&RedPos>=0&&RedPos<=229){
        RedPos=mouseX-40; 
     }
     if(mouseX>=GreenPos+35&&mouseX<=GreenPos+55&& mouseY>=116&&mouseY<=132&&GreenPos>=0&&GreenPos<=229){
       GreenPos=mouseX-40; 
     }
     if(mouseX>=BluePos+35&&mouseX<=BluePos+55&& mouseY>=136&&mouseY<=152&&BluePos>=0&&BluePos<=229){
        BluePos=mouseX-40; 
     }
  }
  }
}

void mouseWheel(MouseEvent event) {
  float wheel_direction = event.getCount()*-1;
  if(grid_mode){
   if(grid_size==10&&wheel_direction<0){
   }else{
   
   grid_size+=wheel_direction*10;
   } 
  }
  
}








boolean level_colide(float x,float y){
  level_terain=loadJSONArray(file_path);
         for(int i=1;i<level_terain.size();i++){
          JSONObject block=level_terain.getJSONObject(i); 
          String type=block.getString("type");
          
         
          if(type.equals("ground")||type.equals("dethPlane")){
             float tx = block.getFloat("x"),ty = block.getFloat("y"),dx = block.getFloat("dx"),dy = block.getFloat("dy");
          float x2 = tx+dx,y2=ty+dy;
            if(x >= tx && x <= x2 && y >= ty && y <= y2/* terain hit box*/){
                return true;
            }
           
          }
          if(type.equals("sloap")){
            float x1 = block.getFloat("x1"),y1 = block.getFloat("y1"),x2 = block.getFloat("x2"),y2 = block.getFloat("y2");
            int rot=block.getInt("rotation");
           if(rot==0){
             if(x<=x2&&y>=y1&&y<=x*((y2-y1)/(x2-x1)) + (y2-(x2*((y2-y1)/(x2-x1))))  ){
              return true; 
             }
            //triangle(X1,Y1,X2,Y2,X2,Y1); 
           }
           if(rot==1){
             if(x>=x1&&y>=y1&&y<=x*((y2-y1)/(x1-x2)) + ( y1-(x2*((y2-y1)/(x1-x2))))  ){
              return true; 
             }
            //triangle(X1,Y1,X1,Y2,X2,Y1); 
           }
           if(rot==2){
             if(x>=x1&&y<=y2&&y>=x*((y2-y1)/(x2-x1)) + ( y2-(x2*((y2-y1)/(x2-x1))))  ){
              return true; 
             }
            //triangle(X1,Y1,X2,Y2,X1,Y2); 
           }
           if(rot==3){
             if(x<=x2&&y<=y2&&y>=x*((y2-y1)/(x1-x2)) + ( y1-(x2*((y2-y1)/(x1-x2))))  ){
              return true; 
             }
            //triangle(X1,Y2,X2,Y2,X2,Y1); 
           }
          }
         }
         
  
  
  return false;
}

boolean level_colide(float x,float y,float z){//3d collions 
  for(int i=1;i<level_terain.size();i++){
          JSONObject block=level_terain.getJSONObject(i); 
          String type=block.getString("type");
          
         
          if(type.equals("ground")||type.equals("dethPlane")||type.equals("holo")){
             float tx = block.getFloat("x"),ty = block.getFloat("y"),tz = block.getFloat("z"),dx = block.getFloat("dx"),dy = block.getFloat("dy"),dz = block.getFloat("dz");
          float x2 = tx+dx,y2=ty+dy,z2=tz+dz;
            if(x >= tx && x <= x2 && y >= ty && y <= y2 && z>=tz && z<=z2/* terain hit box*/){
                return true;
            }
           
          }
         }
         return false;
  
}

boolean player_kill(float x,float y){
  level_terain=loadJSONArray(file_path);
         for(int i=1;i<level_terain.size();i++){
          JSONObject block=level_terain.getJSONObject(i); 
          String type=block.getString("type");
          
         
          if(type.equals("dethPlane")){
             float tx = block.getFloat("x"),ty = block.getFloat("y"),dx = block.getFloat("dx"),dy = block.getFloat("dy");
          float x2 = tx+dx,y2=ty+dy;
            if(x >= tx && x <= x2 && y >= ty && y <= y2/* terain hit box*/){
              
                return true;
            }
           
          }
         }
  
  return false;
}

int colid_index(float x,float y){
 level_terain=loadJSONArray(file_path);
         for(int i=level_terain.size()-1;i>0;i--){
          JSONObject block=level_terain.getJSONObject(i); 
          String type=block.getString("type");
          
         
          if(type.equals("ground")||type.equals("holo")||type.equals("dethPlane")){
             float tx = block.getFloat("x"),ty = block.getFloat("y"),dx = block.getFloat("dx"),dy = block.getFloat("dy");
          float x2 = tx+dx,y2=ty+dy;
            if(x >= tx && x <= x2 && y >= ty && y <= y2/* terain hit box*/){
                return i;
            }
          }
          if(type.equals("goal")){
            float tx = block.getFloat("x"),ty = block.getFloat("y");
            if(x >= tx+camPos && x <= (tx+camPos) + 250 && y >= (ty+camPosY) - 50 && y <= (ty+camPosY) + 50){
              return i;
            }
          }
          if(type.equals("check point")){
            float tx = block.getFloat("x"),ty = block.getFloat("y");
            if(x>=tx-3 && x<= tx+3 && ty-50 <= y && ty>=y){
              return i;
            }
            
          }
          if(type.equals("interdimentional Portal")){
            float tx = block.getFloat("x"),ty = block.getFloat("y");
            
           if(tx>x-25&&tx<x+25&&ty>y-50&&ty<y+60){
             return i;
           }
          }
          if(type.equals("coin")){
            float tx = block.getFloat("x"),ty = block.getFloat("y");
           if(Math.sqrt(Math.pow((x)-tx,2)+Math.pow(y-ty,2))<30){
             return i;
           }
          }
          
          if(type.equals("sloap")||type.equals("holoTriangle")){
            float x1 = block.getFloat("x1"),y1 = block.getFloat("y1"),x2 = block.getFloat("x2"),y2 = block.getFloat("y2");
            int rot=block.getInt("rotation");
           if(rot==0){
             if(x<=x2&&y>=y1&&y<=x*((y2-y1)/(x2-x1)) + (y2-(x2*((y2-y1)/(x2-x1))))  ){
              return i; 
             }
            //triangle(X1,Y1,X2,Y2,X2,Y1); 
           }
           if(rot==1){
             if(x>=x1&&y>=y1&&y<=x*((y2-y1)/(x1-x2)) + ( y1-(x2*((y2-y1)/(x1-x2))))  ){
              return i; 
             }
            //triangle(X1,Y1,X1,Y2,X2,Y1); 
           }
           if(rot==2){
             if(x>=x1&&y<=y2&&y>=x*((y2-y1)/(x2-x1)) + ( y2-(x2*((y2-y1)/(x2-x1))))  ){
              return i; 
             }
            //triangle(X1,Y1,X2,Y2,X1,Y2); 
           }
           if(rot==3){
             if(x<=x2&&y<=y2&&y>=x*((y2-y1)/(x1-x2)) + ( y1-(x2*((y2-y1)/(x1-x2))))  ){
              return i; 
             }
            //triangle(X1,Y2,X2,Y2,X2,Y1); 
           }
          }
          
          if(type.equals("3DonSW")){
            float tx = block.getFloat("x"),ty = block.getFloat("y");
            if(x >= (tx-camPos)-20 && x <= (tx+camPos) + 20 && y >= (ty+camPosY) - 10 && y <= ty+camPosY){
              return i;
            }
          }
          
         }
  
  
  
  return -1;
}

char getCh(int mode){
  if(mode==0){
  if(Character.isLetter(key)||key==' '){
   return key; 
 }
 if(keyCode==32){
  return ' '; 
 }
  
 if(key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='0')
 return key;
}
if(mode==1){
  if(key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='0')
 return key;
}
if(mode==2){
  if(key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='0'||key=='.')
 return key;
}

 return 0;
}

String doBackspace(String imp){
  if(keyCode==8){
   if(imp.length()>1){
    return imp.substring(0,imp.length()-1); 
   }
   else if(imp.length()==1){
    return ""; 
   }
  }
  return imp;
}

String getInput(String in,int x){
  if(getCh(x)!=0){
    in+=getCh(x);
  }
  in=doBackspace(in);
  return in;
}

void turnThingsOff(){
  ground=false;
       check_point=false;
        goal=false;
        deleteing=false;
        moving_player=false;
        holo_gram=false;
        levelOverview=false;
        drawCoins=false;
        drawingPortal=false;
        drawingPortal3=false;
        sloap=false;
        holoTriangle=false;
        dethPlane=false;
        draw3DSwitch1=false;
        draw3DSwitch2=false;
}

int curMills=0,lasMills=0,mspc=0;

void thrdCalc2(){
  println("ere");
  while(loopThread2){
 curMills=millis(); 
 mspc=curMills-lasMills;
 if(editingStage){
   try{
   playerPhysics();
   }catch(Throwable e){
     
   }
 }else{
random(10);//some how make it so it doesent stop the thread
 }
   lasMills=curMills;
   //println(mspc);
  }
}
