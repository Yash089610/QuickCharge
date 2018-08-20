#!/system/bin/sh
#==============================================================================
#
#   File Name : get_cvc_info.sh
#
#   About     : Basic shell file content information.
#
#
#                             Written By
#                             TheHitMan
#                        @xda developers.com
#                           18 August 2018
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
   
   echo ""
   busybox echo -e "\e[00;00m ========= Quick Charge 2.0|3.0 ========= \e[00;37;40m"
   busybox echo -e "\e[00;44m 1. Get CVC Info. \e[00;37;40m"
   echo ""
   echo "             Written By                 "
   busybox echo -e "\e[00;44m             TheHitMan            \e[00;37;40m"
   echo "          @xda developers               "
   echo ""
   
   echo -n "Please select an option [1]: "
   read option 

   if [ $option -eq 1 ]; then
   clear
   echo "Kernel MOD        : CVC[ChargingVoltageController]"
   echo "MOD Type          : Quick Charge"
   echo "Supported Kernel  : Revolt Kernel.EAS"
   echo "Build             : v1.0"
   echo "Status            : Stable"
   echo "Build Date        : 18-August-2018 08:17:05 PM"
   echo "Build v2 Features : - Enables Fast Charging."
   echo "                    - Extreme Battery Life."
   echo "                    - Enable QC 2.0|3.0."
   echo "                    - 4 Different Modes 2400mA | 3000mA | 2000mA | 1800mA."
   echo "                    - Suppor Wall Charger Charging Only."
   echo "                    - Maximum amps allowed for 5V/2A Charger is 2400mA."
   echo "                    - Maximum amps allowed for QC 3.0 18watt Charger 2400mA - 3000mA."
   echo "                    - Maximum Voltage 4.4V."
   echo "                    - High amps(mA)and Low Voltage when battery Charge in between 1% - 85% during charging."
   echo "                    - Low amps(mA) and High Voltage when battery charge in between 85% - 100% during charging."
   echo "Re-run CVC        : Type "run.sh" again..."
   fi
