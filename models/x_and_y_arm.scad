$fa = 1;
$fs = 0.1;

$tabRadius = 77.88 / 2;
$radius = 81.1 / 2;

$cupHeight = 2.5 + 1;
$cupScrewHole = 1.6 / 2;
$cupRadius = 4.75 / 2;

$armHeight = 2;

$gripCount = 6 * 4;
$gripRadius = 0.15;
$trackRadius = $cupRadius / 2;

module cup(){
  difference(){
    union(){
      cylinder($cupHeight,$cupRadius + 1,$cupRadius + 1);
      arm();
    }
    translate([0,0,1])
      cylinder($cupHeight,$cupRadius,$cupRadius);
    translate([0,0,-0.5])
    cylinder(2,$cupScrewHole,$cupScrewHole);
  }
}

module grips(){
  $step = 360 / $gripCount;
  for($angle = [0:$step:360 - $step]){
    rotate([0,0,$angle])
      translate([0,$cupRadius,0])
        cylinder($cupHeight,$gripRadius,$gripRadius);
  }

}

module arm() {
  difference(){
  hull(){
    cylinder($armHeight,$cupRadius * 2,$cupRadius * 2);
    translate([$radius * 2,0,0])
      cylinder($armHeight,$cupRadius * 2,$cupRadius * 2);
  }
  translate([0,0,-0.25])
  hull(){
    translate([$cupRadius * 3, 0, 0])
    cylinder($armHeight + 1,$trackRadius,$trackRadius);
    translate([$radius * 1.95,0,0])
      cylinder($armHeight + 1,$trackRadius,$trackRadius);
  }
}
}

grips();
cup();