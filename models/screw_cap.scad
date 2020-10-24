$fa = 1;
$fs = 0.1;

$tabRadius = 77.88 / 2;
$radius = 81.1 / 2;
$thickness = 5;
$tabWidth = 20;
$tabHeight = 2;

$height = 12;

$tabCount = 6;

$servoWidth = 12.2;
$servoLength = 23;
$servoGripHeight = 8;
$servoWiresWidth = 4;
$servoAngle = 20;
$xServoOffset = 2;

$servoHolderScrewWidth = 2;

$screwWidth = 1.5;

module tabs() {
    intersection() {
        difference() {
            cylinder($tabHeight * 1.5, $tabRadius + 5, $tabRadius + 5);
            translate([ 0, 0, -($tabHeight / 2) ])
                cylinder($tabHeight * 2, $tabRadius, $tabRadius);
        }
        union() {
            $angle = 0;
            for ($angle = [0:(360 / $tabCount):(360 - (360 / $tabCount))]) {
                rotate([ 0, 5, $angle ]) translate([ 0, $radius / 2, 0 ])
                    cube([ $tabWidth, $radius, $tabHeight ], true);
            }
        }
    }
}

module servoHolder() {
    difference() {
        union() {
            cube(
                [
                    $servoWidth + ($thickness), $servoLength + ($thickness),
                    $servoGripHeight
                ],
                true);
            // screw holders
            translate([ 0, -(($servoLength / 2) + ($thickness / 2)), 0 ])
                cylinder($servoGripHeight, $servoHolderScrewWidth,
                         $servoHolderScrewWidth, true);
            translate([ 0, ($servoLength / 2) + ($thickness / 2), 0 ])
                cylinder($servoGripHeight, $servoHolderScrewWidth,
                         $servoHolderScrewWidth, true);
        }
        // servo hole
        translate([ 0, 0, -0.25 ])
            cube([ $servoWidth, $servoLength, $servoGripHeight + 1 ], true);
        // servo wire hole
        translate([ 0, -($thickness / 4), -0.25 ]) cube(
            [ $servoWiresWidth, $servoLength, $servoGripHeight + 1 ], true);

        // screw holes
        translate([ 0, -(($servoLength / 2) + ($thickness / 2)), -0.25 ])
            cylinder($servoGripHeight + 1, $servoHolderScrewWidth / 2,
                     $servoHolderScrewWidth / 2, true);
        translate([ 0, ($servoLength / 2) + ($thickness / 2), -0.25 ])
            cylinder($servoGripHeight + 1, $servoHolderScrewWidth / 2,
                     $servoHolderScrewWidth / 2, true);
    }
}

module mountingPoint() {
    difference() {
        hull() {
            cube([ 20, 40, 2 ], true);
            translate([ 0, 0, -2 ]) cube([ 20 / 2, 40 / 2, 5 ], true);
        }
        for ($screwX = [-10:5:10]) {
            for ($screwY = [-20:5:20]) {
                translate([ $screwX, $screwY, 0 ])
                    cylinder(6, $screwWidth / 2, $screwWidth / 2, true);
            }
        }
    }
}

module cableLoop() {
    cube([ 4, 6, 2 ], true);
    translate([ -(1), 0, 2 ]) cube([ 2, 4, 4 ], true);
}

tabs();

difference() {
    cylinder($height, $radius + $thickness, $radius + $thickness);
    translate([ 0, 0, -0.5 ]) cylinder($height + 1, $radius, $radius);
}
for ($cableLoopAngle = [45:20:135]) {
    rotate([ 0, 0, $cableLoopAngle ]) translate([ -($radius + (6.5)), 0, 1 ])
        cableLoop();
}
for ($cableLoopAngle = [-45:-20:-135]) {
    rotate([ 0, 0, $cableLoopAngle ]) translate([ -($radius + (6.5)), 0, 1 ])
        cableLoop();
}
rotate([ 0, 0, -$servoAngle ]) translate([ -($radius + ($servoWidth)), 0, 8 ])
    servoHolder();
rotate([ 0, 0, $servoAngle ])
    translate([ -($radius + ($servoWidth)), 0, 8 + $xServoOffset ])
        mirror([ 0, 1, 0 ]) servoHolder();
translate([ $radius + ($thickness), 0, $height ]) rotate([ 0, 60, 0 ])
    mountingPoint();
