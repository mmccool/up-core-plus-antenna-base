// UP Core Plus Antenna Base
// Developed by: Michael McCool
// Copyright 2018 Michael McCpp;
// License: CC BY 3.0. See LICENSE.md
include <tols.scad>
//include <smooth_model.scad>
include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>

module ext() {
  color("grey") {
    translate([2.5,0,3.8])
      rotate([90,0,0])
        rotate([0,90,0])
          import("ext/heatsink.stl", convexity=10);
  }
  color("green") {
    import("ext/pcb.stl", convexity=10);
  }
}

standoff_or = 4.64/2;
standoff_os = 6;
standoff_ir = 2.5/2;
standoff_is = 20;
standoff_h = 9;
module standoff() {
  color("silver") difference() {
    cylinder(r=standoff_or,h=standoff_h,$fn=standoff_os);
    translate([0,0,-1]) cylinder(r=standoff_ir,h=standoff_h+2,$fn=standoff_is);
  }
}

pcb_xs = 83;
pcb_xi = 2.5;
pcb_xo = 19;
pcb_ys = 49;
pcb_yi = 0;
module assembly() {
  translate([-pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([-pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xo,-pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xo, pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  ext();
}

assembly();
