// Define all dimensions

gridDensity = 0.5;

dl = 2500; // domain length
dh = 700; // domain height

cl = 177.8; // car length
ch = 40; // car height
cbot = 9.525; // car bottom clearance
cxloc = cl*1.5; // x location of front of car relative to domain length
cxmid = cxloc + cl/2; // x location of front of car relative to domain length

bh = 75; // boundary layer height and front length
bl = 200; // boundary layer length

gridsize = dl/(100*gridDensity);

// Domain
Point(1) = {0,0,0,gridsize};
Point(2) = {dl,0,0,gridsize};
Point(3) = {dl,dh,0,gridsize};
Point(4) = {0,dh,0,gridsize};

// Car
Point(5) = {cxloc,cbot,0,gridsize/20};
Point(6) = {cxloc+cl,cbot,0,gridsize/20};
Point(7) = {cxloc+cl/2,cbot+ch,0,gridsize/20};
Spline(14) = {6,7,5};
//Point(8) = {cxloc,cbot+ch,0,gridsize/20};


//Point(9) = {cxloc, cbot, -cw/2};
//Point(10) = {cxloc + cl,cbot,-cw/2};
//Point(11) = {cxloc + cl*5/8,cbot + ch,-cw/2};
//Line(13) = {9,10};
//Spline(14) = {9,11,10};

// Boundary Layer
Point(9) = {cxloc-bh,0,0,gridsize/5};
Point(10) = {cxloc+cl+bl,0,0,gridsize/5};
Point(11) = {cxloc+cl+bl,cbot+ch+bh,0,gridsize/5};
Point(12) = {cxloc-bh,cbot+ch+bh,0,gridsize/5};

Point(13) = {cxloc,0,0,gridsize/10};
Point(14) = {cxloc+cl/2,0,0,gridsize/10};
Point(15) = {cxloc+cl,0,0,gridsize/10};

//Point(13) = {cxloc,0,0,gridsize};
//Point(14) = {cxloc-bh,cbot,0,gridsize};
//Point(15) = {cxloc-bh,cbot+ch,0,gridsize};
//Point(16) = {cxloc,cbot+ch+bh,0,gridsize};

//Point(17) = {cxloc+cl,cbot+ch+bh,0,gridsize};
//Point(18) = {cxloc+cl+bl,cbot+ch,0,gridsize};
//Point(19) = {cxloc+cl+bl,cbot,0,gridsize};
//Point(20) = {cxloc+cl,0,0,gridsize};

// Additional points for mesh blocks
//Point(21) = {0,cbot+ch+bh,0,gridsize};
//Point(22) = {cxloc-bh,dh,0,gridsize};
//Point(23) = {cxloc+cl+bl,dh,0,gridsize};
//Point(24) = {dl,cbot+ch+bh,0,gridsize};


Line(1) = {1, 4};
//+
Line(2) = {4, 3};
//+
Line(3) = {3, 2};
//+
Line(4) = {2, 10};
//+
Line(5) = {10, 11};
//+
Line(6) = {11, 12};
//+
Line(7) = {12, 9};
//+
Line(8) = {9, 1};
//+
Line(9) = {9, 13};
//+
Line(10) = {13, 14};
//+
Line(11) = {14, 15};
//+
Line(12) = {15, 10};
//+
Line(13) = {5, 6};
//+
//Line(14) = {6, 7};
//+
//Line(15) = {7, 5};
//+
Curve Loop(1) = {8, 1, 2, 3, 4, 5, 6, 7};
//+
Plane Surface(1) = {1};
//+
Curve Loop(2) = {7, 9, 10, 11, 12, 5, 6};
//+
Curve Loop(3) = {13, 14};
//+
Plane Surface(2) = {2, 3};

//+
Extrude {0, 0, 40} {
  Surface{1}; Surface{2}; Layers {1}; Recombine;
}

//+
Physical Surface("inlet", 104) = {31};
//+
Physical Surface("outlet", 105) = {39};
//+
Physical Surface("top", 106) = {35};
//+
Physical Surface("bottom", 107) = {43, 86, 82, 78, 74, 27};
//+
Physical Surface("frontAndBack", 108) = {1, 56, 2, 103};
//+
Physical Surface("car", 109) = {98, 102};
//+
Physical Volume("volume", 110) = {2, 1};
