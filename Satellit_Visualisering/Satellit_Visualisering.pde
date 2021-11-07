//https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=CLVMJV-EYD9T6-TRB4BW-4SQ4
JSONObject j;
JSONArray positionsJson;
PVector P1 = new PVector();
PVector P2 = new PVector();
JSONObject pos1;
JSONObject pos2;

float sat1Lon, sat1Lat, sat1Alt;

float sat2Lon, sat2Lat, sat2Alt;

float angle; // Begge angle er 0 til at starte med
float satAngle;
float r = 200; //radius af jorden
float ah; // Vinklen mellem de to vector pos1 og pos2
float h;

float theta, phi;

float theta2, phi2;

float x1, x2, y1, y2, z1, z2;
Earth earth = new Earth();

void setup() {
  size(1000, 1000, P3D);
  earth.setup();
  j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=CLVMJV-EYD9T6-TRB4BW-4SQ4");
  positionsJson = j.getJSONArray("positions");

  pos1 = positionsJson.getJSONObject(0);
  pos2 = positionsJson.getJSONObject(1);

  sat1Lon = pos1.getFloat("satlongitude");
  sat1Lat = pos1.getFloat("satlatitude");
  sat1Alt = pos1.getFloat("sataltitude");

  sat2Lon = pos2.getFloat("satlongitude");
  sat2Lat = pos2.getFloat("satlatitude");  
  sat2Alt = pos2.getFloat("sataltitude");

  pos1 = positionsJson.getJSONObject(0);
  pos2 = positionsJson.getJSONObject(1);

  /*sat1Lon = pos1.getFloat("satlongitude");
   sat1Lat = pos1.getFloat("satlatitude");
   
   sat2Lon = pos2.getFloat("satlongitude");
   sat2Lat = pos2.getFloat("satlatitude");*/
  println(sat1Lon, sat1Lat, sat1Alt);
  println(sat2Lon, sat2Lat, sat2Alt);
}

void draw() {

  earth.drawEarth();

  h = r*(sat1Alt/6000.0) + r;

  theta = radians(sat1Lat);
  phi = radians(sat1Lon) + PI;
  x1 = h * cos(theta) * cos(phi);
  y1 = -h * sin(theta);
  z1 = -h * cos(theta) * sin(phi);

  theta2 = radians(sat2Lat);
  phi2 = radians(sat2Lon) + PI;
  x2 = h * cos(theta2) * cos(phi2);
  y2 = -h * sin(theta2);
  z2 = -h * cos(theta2) * sin(phi2);


  P1.set(x1, y1, z1);
  P2.set(x2, y2, z2);
  ah = PVector.angleBetween(P1, P2);
  satAngle+= ah * 25;

  PVector P3 = P1.cross(P2); //finder vinklen mellem de to vektor

  pushMatrix();
  translate(width*0.5, height*0.5); //sætter den i midten
  //rotateY(angle);

  rotate(satAngle, P3.x, P3.y, P3.z);
  translate(x1, y1, z1);

  fill(200);
  box(20, 5, 5); //tegner sateliten
  popMatrix();
}
