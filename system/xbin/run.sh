#!/system/bin/sh
#==============================================================================
#
#   File Name : run.sh
#
#   About     : Execute several other bash script.
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
   busybox echo -e "\e[00;00m ========= Control Charging Voltage ========= \e[00;37;40m"
   busybox echo -e "\e[00;44m 1. Read Before Applying This Kernel MOD      \e[00;37;40m"
   busybox echo -e "\e[00;00m 2. Start Testing                             \e[00;37;40m"
   busybox echo -e "\e[00;41m 3. Toggle Quick Charge                       \e[00;37;40m"
   busybox echo -e "\e[00;00m 4. Reset and uninstall | No Reboot           \e[00;37;40m"
   busybox echo -e "\e[00;00m 5. Exit                                      \e[00;37;40m"
   echo ""
   echo "             Written By                 "
   busybox echo -e "\e[00;44m             TheHitMan            \e[00;37;40m"
   echo "          @xda developers               "
   echo ""
   
   echo -n "Please select an option [1-5]: "
   read option 

   if [ $option -eq 1 ]; then
   clear
   sh /system/xbin/get_cvc_info.sh
   
   elif [ $option -eq 2 ]; then
   clear
   sh /system/xbin/test.sh
   
   elif [ $option -eq 3 ]; then
   clear
   sh /system/xbin/ch_type.sh

   elif [ $option -eq 4 ]; then
   clear
   sh /system/xbin/uninstaller.sh
   
   #unmount
   elif [ $option -eq 5 ]; then
   $BB mount -t ext4 -o remount,ro /system
   echo ""
   echo "*End*" 
   echo "Like it..? post your review on thread. ;)"
   exit
   else
   echo ""
   echo "Invalid option, please try again !"
   sleep 1
   fi

