SetFactory("OpenCASCADE");

// Define all dimensions
dl = 2500; // domain length
dw = 700; // domain width
dh = 300; // domain height

cl = 177.8; // car length
cw = 69.85; // car width
ch = cw*2/3; // car height
cbot = 9.525; // car bottom clearance
cxloc = cl*4; // x location of front of car relative to domain length
cxmid = cxloc + cl/2; // x location of front of car relative to domain length

ww = 10.541; // wheel width
wr = 30.226/2; // wheel radius
wl = 85; // wheelbase length
front_wc = cxmid - wl/2; // x coordinate of front wheels
rear_wc = cxmid + wl/2; // x coordinate of rear wheels

al = ww/4; // axle length
ar = wr/4; // axle radius

// Domain
Box(1) = {0, 0, -dw/2, dl, dh, dw};

// Car body
Box(2) = {cxloc, cbot, -cw/2, cl, ch, cw};

// Wheels
Cylinder(3) = {front_wc, wr, cw/2 + al, 0, 0, ww, wr};
Cylinder(4) = {front_wc, wr, -cw/2 - al, 0, 0, -ww, wr};
Cylinder(5) = {rear_wc, wr, cw/2 + al, 0, 0, ww, wr};
Cylinder(6) = {rear_wc, wr, -cw/2 - al, 0, 0, -ww, wr};

// Axles
Cylinder(7) = {front_wc, wr, cw/2, 0, 0, al, ar};
Cylinder(8) = {front_wc, wr, -cw/2, 0, 0, -al, ar};
Cylinder(9) = {rear_wc, wr, cw/2, 0, 0, al, ar};
Cylinder(10) = {rear_wc, wr, -cw/2, 0, 0, -al, ar};

// Combine all car pieces
BooleanUnion(11) = { Volume{2}; Delete; }{ Volume{7}; Delete; };
BooleanUnion(12) = { Volume{11}; Delete; }{ Volume{8}; Delete; };
BooleanUnion(13) = { Volume{12}; Delete; }{ Volume{9}; Delete; };
BooleanUnion(14) = { Volume{13}; Delete; }{ Volume{10}; Delete; };
BooleanUnion(15) = { Volume{14}; Delete; }{ Volume{3}; Delete; };
BooleanUnion(16) = { Volume{15}; Delete; }{ Volume{4}; Delete; };
BooleanUnion(17) = { Volume{16}; Delete; }{ Volume{5}; Delete; };
BooleanUnion(18) = { Volume{17}; Delete; }{ Volume{6}; Delete; };

BooleanDifference(19) = { Volume{1}; Delete; }{ Volume{18}; Delete; };

// Physical Volumes
Physical Volume("volume") = {19};

// Physical Surfaces
Physical Surface("inlet") = {1};
Physical Surface("bottom") = {2};
//Physical Surface("right") = {3};
Physical Surface("frontAndBack") = {3, 5};
Physical Surface("top") = {4};
//Physical Surface("left") = {5};
Physical Surface("outlet") = {6};
Physical Surface("car") = {7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31};

// Meshing:
Mesh.CharacteristicLengthFactor = 0.04; // .05 yields ~1M elements
Characteristic Length{PointsOf{Physical Surface{"car"};}} = 1;
Characteristic Length{PointsOf{Physical Surface{"inlet"};}} = 10;
Characteristic Length{PointsOf{Physical Surface{"bottom"};}} = 5;
//Characteristic Length{PointsOf{Physical Surface{"right"};}} = 10;
Characteristic Length{PointsOf{Physical Surface{"frontAndBack"};}} = 10;
Characteristic Length{PointsOf{Physical Surface{"top"};}} = 10;
//Characteristic Length{PointsOf{Physical Surface{"left"};}} = 10;
Characteristic Length{PointsOf{Physical Surface{"outlet"};}} = 10;

// Generate Mesh
Mesh 3;
Mesh.MshFileVersion = 2.2;