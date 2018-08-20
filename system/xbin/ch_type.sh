#!/system/bin/sh
#==============================================================================
#
#  File Name   : ch_type.sh
#
#  About       : Define charger type before apply.
#
#  Requirement : latest Revolt Kernel.
#
#
#                             Written By
#                             TheHitMan
#                        @xda developers.com
#                           20 August 2018
#==============================================================================

BB="/system/xbin/busybox"

# mounting process
$BB mount -t ext4 -o remount,rw /system

clear

id=`id`; id=`echo ${id#*=}`; id=`echo ${id%%\(*}`; id=`echo ${id%% *}`
if [ "$id" != "0" ] && [ "$id" != "root" ]; 
then
sleep 1
echo $divider
echo ""
echo "You are NOT running as root..."
echo ""
echo $divider
sleep 1
echo ""
echo "Please type 'su' first before typing 'run.sh'..."
echo ""
exit
fi

busybox echo -e "\e[00;41m == Please select an option depend on charger type == \e[00;37;40m"
echo " "
echo "1) Do you use Quick Charge 3.0 Charger | Yes"
echo "2) Do you use 5V/2A Charger            | Yes"
echo "3) Exit                                | No"
echo " "
echo "             Written By                 "
busybox echo -e "\e[00;44m             TheHitMan            \e[00;37;40m"
echo "          @xda developers               "
echo " "

echo -n "Please select an option[1-3]: "
read option

if [ "$option" == "1" ]; then
   clear
   echo " "
busybox echo -e "\e[00;41m == Applying QC 3.0 Charger Configuration == \e[00;37;40m"
   echo " "
   echo "- Enable QuickCharge 3.0"
   echo "1" > /sys/class/power_supply/battery/allow_hvdcp3;
   echo "- Enable FastCharge 2.0"
   echo "1" > /sys/kernel/fast_charge/force_fast_charge;
   echo "- Apply QuickCharge Parameters"
   sleep 4
   clear
   sleep 2
   sleep 3
   QCM="/system/xbin/charging_controller.sh"
   sh $QCM
elif [ "$option" == "2" ]; then
   clear
   echo " "
busybox echo -e "\e[00;41m == Applying 5V/2A Charger Configuration == \e[00;37;40m"
   echo " "
   echo "- Disable QuickCharge 3.0"
   echo "0" > /sys/class/power_supply/battery/allow_hvdcp3;
   echo "- Enable FastCharge 2.0"
   echo "1" > /sys/kernel/fast_charge/force_fast_charge;
   echo "- Apply QuickCharge Parameters"
   sleep 4
   clear
   sleep 2
   sleep 3
   QCM="/system/xbin/charging_controller.sh"
   sh $QCM
elif [ "$option" == "3" ]; then
   exit 0
fi
