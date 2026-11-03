// Front Door Colours - A Neighbourhood Palette

Table table;
ArrayList<Door> doors;

int cols = 10;      // doors per row
float cell = 70;    // space given to each door
float margin = 50;  // gap around the edge

void setup() {
  size(800, 850);

  table = loadTable("doors.csv", "header");
  doors = new ArrayList<Door>();

  // create one Door object for every row in the CSV
  for (TableRow row : table.rows()) {
    Door d = new Door(
      row.getInt("door_id"),
      row.getString("date"),
      row.getString("time"),
      row.getString("weather"),
      row.getString("colour"),
      row.getInt("kerb_appeal")
    );
    doors.add(d);
  }
}

void draw() {
  background(240);

  // every door is displayed in order
  for (int i = 0; i < doors.size(); i++) {
    float x = margin + (i % cols) * cell + cell / 2;
    float y = margin + (i / cols) * cell + cell;
    doors.get(i).display(x, y);
  }
}

class Door {
  int id;
  String date, time, weather, colourName;
  int kerbAppeal;
  color fillColour;

  Door(int id, String date, String time, String weather, String colourName, int kerbAppeal) {
    this.id = id;
    this.date = date;
    this.time = time;
    this.weather = weather;
    this.colourName = colourName;
    this.kerbAppeal = kerbAppeal;
    this.fillColour = colourFromName(colourName);
  }

  // returns a width based on kerb appeal (1 to 3)
  float doorWidth() {
    return 20 + kerbAppeal * 8;
  }

  // Returns a colour value for a colour name
  color colourFromName(String name) {
    String n = name.trim().toLowerCase();
    if (n.equals("red"))        return color(180, 30, 40);
    if (n.equals("blue"))       return color(40, 90, 170);
    if (n.equals("light blue")) return color(130, 170, 210);
    if (n.equals("navy"))       return color(25, 45, 95);
    if (n.equals("green"))      return color(50, 130, 70);
    if (n.equals("dark green")) return color(30, 80, 50);
    if (n.equals("black"))      return color(20, 20, 20);
    if (n.equals("white"))      return color(250, 250, 245);
    if (n.equals("cream"))      return color(240, 228, 195);
    if (n.equals("grey"))       return color(120, 120, 125);
    if (n.equals("yellow"))     return color(230, 190, 40);
    if (n.equals("orange"))     return color(220, 120, 50);
    if (n.equals("pink"))       return color(225, 150, 170);
    if (n.equals("purple"))     return color(110, 60, 130);
    if (n.equals("brown"))      return color(105, 65, 40);
    if (n.equals("teal"))       return color(40, 130, 130);
    return color(180);  // unknown name shows as light grey
  }

  // draws the door 
  void display(float px, float py) {
    float w = doorWidth();
    float h = w * 1.6;
    stroke(0, 40);
    fill(fillColour);
    rect(px - w / 2, py - h, w, h, w / 2, w / 2, 0, 0);
  }
}
