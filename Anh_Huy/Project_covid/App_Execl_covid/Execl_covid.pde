import processing.serial.*;
//import winuser.h;
Serial port;

Table table; // Table object
PFont font;
String rawData;
String[] data;
int stt=0;

void setup() {
  size(400, 400);
  port = new Serial(this, "COM3", 115200);
  /* hiển thị ra màn hình */
  font = loadFont("TimesNewRomanPSMT-48.vlw");
  textFont(font, 32);
  textAlign(CENTER);
  fill(0);
  /* tạo bảng lưu dữ liệu */
  table = new Table();
  /* thêm cột cho bảng */
  //table.addColumn("UID");
  table.addColumn("STT");
  table.addColumn("Ho Va Ten");
  table.addColumn("Tinh Trang Chich Ngua");
}

void draw() {
  background(255);
  rawData = "";
  if (port.available() > 0) {
    rawData = port.readString();
  //  text(rawData , 200 ,50);
  //  TableRow row = table.addRow();
  //  row.setString("UID", rawData);
  //  saveTable(table, "D:\\Recording\\IDtable.csv");
  stt++;
  //String s = to_string(stt);
  }
  
  if (rawData != "") {
    /* tách dữ liệu từ raw data nhận từ Serial */
    data = split(rawData, ';');
    
    /* Exception handling */
    try {
      text(data[0], 200, 150);
      text(data[1], 200, 250);
      text(stt, 200, 250);
      //text(data[2], 200, 250);
      
      TableRow row = table.addRow();
      row.setInt("STT", stt);
      row.setString("Ho Va Ten", data[0]);
      row.setString("Tinh Trang Chich Ngua", data[1]);
      //row.setString("Age", data[2]);
      //String[] link = loadString("link.txt");
      saveTable(table, "D:\\Excel\\Covid.csv");
    } 
    catch (Exception e) {
      background(255);
      data = new String[3];
      data[0] = data[1] = "Error";
      text(data[0], 200, 150);
      text(data[1], 200, 250);
      //text(data[2], 200, 250);
    }
  }
   delay(500);
}
