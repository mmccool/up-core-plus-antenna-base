# UP Core Plus Antenna Base
A 3D printable base for the [Aaeon UP Core Plus](https://up-shop.org/up-ai-edge/231-up-core-plus.html) to mount WiFi antennas.
Can work with either stick-on flat internal antennas or external RP-SMA antennas. 
Also provides space to mount the RTC battery internally and protects the bottom of the board.

## Mounting
To mount, use four to six M2.5 x 8 bolts, assuming the 9mm spacers that come with the board are used.
The spacers fit snugly inside the case, so you can omit the bolts if you want; the case can be held on by friction.
M2.6 bolts will not work; they will sort of go partway in, then jam (guess how I figured this out...)

## Antennas
You need internal antennas and\or RP-SMA pigtails with the smaller MHF4 connectors, not (the more common) U.FL connectors.

## Printing
My STLs may have a built-in scale of 94.5% in x and y to correct for my own printer's (mis-)calibration.  This can be easily adjusted in the OpenSCAD file.  If necessary, rescale for your printer when slicing or re-export the STL from OpenSCAD with a calibration factor suitable for your printer.  It's better to use the scale factors in the OpenSCAD file for this as the script is written to automatically keep the walls a nice multiple of the nozzle width.  The examples below were printed with a 0.8mm nozzle and a 0.2mm layer height in PLA.

## Renderings

![Perspective Rendering of Base with PCB and Heatsink, Front](pers.png)

![Perspective Rendering of Base with PCB and Heatsink, Back](persB.png)

## Images

![Image of Printed Base with UP Core Plus, Front](images/upcoreplus_base_front.jpg)

![Image of Printed Base with UP Core Plus, Inside](images/upcoreplus_base_inside.jpg)
