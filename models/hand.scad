$fs = 0.1;

module snake(parts = []) {
    union() {
        renderSnakePart(0, parts);
    }
}

module renderSnakePart(index, parts) {
    partParams = parts[index];
    height = partParams[0];
    radius = partParams[1];
    rotate([ partParams[2], partParams[3], partParams[4] ]) {
        cylinder(height, radius, radius);
        translate([ 0, 0, height ]) {
            if (index + 1 != len(parts)) {
                renderJoint(parts[index + 1], radius);
                renderSnakePart(index + 1, parts);
            }
        }
    }
}

module renderJoint(nextPart, thisRadius) {
    hull() {
        cylinder(0.1, thisRadius, thisRadius);
        rotate([ nextPart[2], nextPart[3], nextPart[4] ]) {
            cylinder(0.1, nextPart[1], nextPart[1]);
        }
    }
}

module fingers() {
    snake([
        [ 4, 1, -95, 0, 0 ], [ 1.8, 0.9, -85, 0, 0 ], [ 2.7, 0.8, -85, 0, 0 ]
    ]);

    translate([ -2, 0, 0 ]) {
        snake([
            [ 4.2, 1, -92, 0, 0 ], [ 1.9, 0.9, -85, 0, 0 ],
            [ 2.8, 0.8, -85, 0, 0 ]
        ]);
    }

    translate([ -4, 0, 0 ]) {
        snake([
            [ 4, 1, -96, 0, 0 ], [ 1.8, 0.9, -85, 0, 0 ],
            [ 2.7, 0.8, -85, 0, 0 ]
        ]);
    }

    translate([ -6, 0, 0 ]) {
        snake([
            [ 3.3, 0.9, -98, 0, 0 ], [ 1.6, 0.85, -85, 0, 0 ],
            [ 2.2, 0.75, -85, 0, 0 ]
        ]);
    }
}

module palm() {
    translate([ -7, -0.5, -6 ]) {
        cube([ 9.2, 1.5, 6.2 ]);
        translate([ 4.5, 0, 0 ]) scale([ 1, 0.25, 1 ])
            cylinder(6.2, 9.1 / 2, 9.2 / 2);
    }
}

module thumb() {
    translate([ 0, 0, -5 ]) snake([
        [ 4, 1.5, 0, 50, 45 ], [ 3.7, 1, -85, 0, 0 ], [ 3.2, 0.95, -44, -10, 0 ]
    ]);
}

fingers();
palm();
thumb();
