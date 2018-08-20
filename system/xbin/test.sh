#!/system/bin/sh

FC="/sys/kernel/fast_charge/force_fast_charge"
QC="/sys/class/power_supply/battery/allow_hvdcp3"
FAST_CHARGE="/sys/kernel/fast_charge"
QUICK_CHARGE="/sys/class/power_supply/battery"
if [ -e "$QC" ] || [ -e "$FC" ]; then
   echo "Fast Charge Toggle found in :" $FAST_CHARGE
   echo "Quick Charge Toggle found in :" $QUICK_CHARGE
else
   echo "Quick Charge & Fast Charge Toggle Not found..."
fi

MSM="/sys/module/msm_thermal"
INTELLI="/sys/module/msm_thermal/parameters/enabled"
if [ -e $INTELLI ]; then
   echo "Intelli-Thermal v3.0 Driver found in :" $MSM
else
   echo "Intelli-Thermal v3.0 Driver not found in :" $MSM
fi
