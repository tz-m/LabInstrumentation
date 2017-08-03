#!/bin/sh

CONFIG_FILE=config.conf

INCREASE_VALUE="$@"

Vextract=`expr 0`
Vthgem1=`expr 550 + $INCREASE_VALUE`
Vtrans1=`expr 90`
Vthgem2=`expr 550 + $INCREASE_VALUE`
Vtrans2=`expr 90`
Vthcobra=`expr 500 + $INCREASE_VALUE`
Vanodecath=`expr 125`

Vtop2=`expr 0`

Vbot1=`expr $Vtop2 - $Vtrans1`
Vtop1=`expr $Vbot1 - $Vthgem1`
Vgrid=`expr $Vtop1 + $Vextract`
Vbot2=`expr $Vtop2 + $Vthgem2`
Vtopstrip=`expr $Vbot2 + $Vtrans2`
Vcathode=`expr $Vtopstrip + $Vthcobra`
Vanode=`expr $Vcathode + $Vanodecath`
Vplane=`expr $Vcathode`

    cat > $CONFIG_FILE <<EOF
# {P or N} {ch. num.} {VSET} {ISET} {PW} {TRIP_TIME} {SVMAX} {RAMP_DOWN} {RAMP_UP} {PWDOWN} {IMON_RANGE}
N 0 ${Vgrid/-/}  0.500 1 10 3000 50 10 1 0
N 1 ${Vtop1/-/}  0.500 1 10 3000 50 10 1 0
N 2 0            0.500 0 10 3000 50 10 1 0
N 3 ${Vtop2/-/}  0.500 1 10 3000 50 10 1 0
N 4 0            0.500 0 10 3000 50 10 1 0
N 5 ${Vbot1/-/}  0.500 1 10 3000 50 10 1 0
P 0 ${Vbot2}     0.500 1 10 3000 50 10 1 0
P 1 0            1.000 0 10  100 50 10 1 0
P 2 ${Vtopstrip} 0.500 1 10 3000 50 10 1 0
P 3 ${Vcathode}  0.500 1 10 3000 50 10 1 0
P 4 ${Vanode}    0.500 1 10 3000 50 10 1 0
P 5 ${Vplane}    0.500 1 10 3000 50 10 1 0
EOF
