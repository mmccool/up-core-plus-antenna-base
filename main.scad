// UP Core Plus Antenna Base
// Developed by: Michael McCool
// Copyright 2018 Michael McCpp;
// License: CC BY 3.0. See LICENSE.md
include <tols.scad>
//include <smooth_model.scad>
include <smooth_make.scad>
include <bolt_params.scad>
use <bolts.scad>

// scale factors (to correct for imperfect printer)
sz = 1.0;
sxy = 0.945;

// critical dimensions that must be a multiple of nozzle width or layer height
nozzle_r = 0.8;
layer_h = 0.2;
wall_t = (3*nozzle_r + tol)/sxy;
floor_h = (10*layer_h + tol)/sz;

// whether to include RP-SMA holes
use_sma = true;

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
module standoffs() {
  translate([-pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([-pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xo,-pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xo, pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,-standoff_h]) standoff();
  translate([ pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,-standoff_h]) standoff();
}

base_cr = 10/2;
// base_ir = standoff_or + 1;
base_ir = base_cr - wall_t;
base_iir = 1;
base_sm = 50;
base_h = 5;
base_hh = floor_h;
base_H = base_h + standoff_h;
base_br = 2.6/2;
base_csh = 2.5; // bolt head height
base_csr = 5/2;
base_csdr = base_csr - base_br;
base_pw = 2*standoff_or;

module bolt_hole() {
  translate([0,0,-1]) 
    cylinder(r=base_br,h=base_h+2,$fn=base_sm);
  translate([0,0,-1]) 
    cylinder(r=base_csr,h=base_csh+1-base_csdr,$fn=base_sm);
  translate([0,0,base_csh-base_csdr-10*eps]) 
    cylinder(r1=base_csr,r2=base_br,h=base_csdr,$fn=base_sm);
}

sma_r = 6.27/2 + tol;
sma_f = 6.3-5.83;
sma_yo = 14;
module sma_hole() {
  rotate([0,-90,0]) {
    difference() {
      cylinder(r=sma_r,h=10,$fn=30);
      translate([sma_f-3*sma_r,-sma_r,-1]) 
        cube([2*sma_r,2*sma_r,12]);
    }
  }
}

module base() {
  difference() {
    // exterior
    hull() {
      translate([0,0,-base_H]) {
        translate([-pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_cr,h=base_H,$fn=base_sm);
        translate([-pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_cr,h=base_H,$fn=base_sm);
        translate([ pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_cr,h=base_H,$fn=base_sm);
        translate([ pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_cr,h=base_H,$fn=base_sm);
      }
    }
    // cavity
    hull() {
      translate([0,0,-standoff_h]) {
        translate([-pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_ir,h=standoff_h+1,$fn=base_sm);
        translate([-pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_ir,h=standoff_h+1,$fn=base_sm);
        translate([ pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_ir,h=standoff_h+1,$fn=base_sm);
        translate([ pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,0]) 
          cylinder(r=base_ir,h=standoff_h+1,$fn=base_sm);
      }
    }
    // central cavity
    hull() {
      translate([0,0,-standoff_h-base_h+base_hh]) {
        translate([-pcb_xs/2+pcb_xi-base_ir+base_iir+eps,
                   -pcb_ys/2+pcb_yi+base_pw+base_iir,0]) 
          cylinder(r=base_iir,h=standoff_h+1,$fn=base_sm);
        translate([-pcb_xs/2+pcb_xi-base_ir+base_iir+eps, 
                    pcb_ys/2+pcb_yi-base_pw-base_iir,0]) 
          cylinder(r=base_iir,h=standoff_h+1,$fn=base_sm);
        translate([ pcb_xs/2+pcb_xi+base_ir-base_iir-eps,
                   -pcb_ys/2+pcb_yi+base_pw+base_iir,0]) 
          cylinder(r=base_iir,h=standoff_h+1,$fn=base_sm);
        translate([ pcb_xs/2+pcb_xi+base_ir-base_iir-eps, 
                    pcb_ys/2+pcb_yi-base_pw-base_iir,0]) 
          cylinder(r=base_iir,h=standoff_h+1,$fn=base_sm);
      }
    }
    // bolt holes
    translate([0,0,-standoff_h-base_h-eps]) {
      translate([-pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,0]) 
        bolt_hole();
      translate([-pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,0]) 
        bolt_hole();
      translate([ pcb_xo,-pcb_ys/2+pcb_yi,0]) 
        bolt_hole();
      translate([ pcb_xo, pcb_ys/2+pcb_yi,0]) 
        bolt_hole();
      translate([ pcb_xs/2+pcb_xi,-pcb_ys/2+pcb_yi,0]) 
        bolt_hole();
      translate([ pcb_xs/2+pcb_xi, pcb_ys/2+pcb_yi,0]) 
        bolt_hole();
    }
    // RTC battery wire notch
    translate([-pcb_xs/2+3,-9.25,0])
      rotate([0,-90,0])
        cylinder(r=3/2,h=10,$fn=20);
    // SMA holes
    if (use_sma) {
      translate([-pcb_xs/2+3,-sma_yo,-base_H/2])
        sma_hole();
      translate([-pcb_xs/2+3, sma_yo,-base_H/2])
        sma_hole();
    }
  }
}

module assembly() {
  ext();
  standoffs();
  //translate([0,0,-0.5]) 
  //  color([0.5,0.5,0.5,1]) 
  base();
}

assembly();

// to print
//scale([sxy,sxy,sz]) base();
