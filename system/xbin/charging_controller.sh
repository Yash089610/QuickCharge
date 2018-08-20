#!/system/bin/sh
#==============================================================================
#
#  File Name   : charging_controller.sh
#
#  About       : Control Charging Voltage.
#                Enable Fast Charging.
#                Kernel Specific.
#
#  Requirement : latest Revolt Kernel.
#
#
#                             Written By
#                             TheHitMan
#                        @xda developers.com
#                           18 August 2018
#==============================================================================

BB="/system/xbin/busybox"
KA="/system/xbin/ka.sh"

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
   busybox echo -e "\e[00;41m ==== Enable Quick Charge 2.0|3.0 ==== \e[00;37;40m"
   echo "1. Toggle Quick Charge 2.0|3.0| upto 2400mA & 3000mA"
   echo "2. Toggle Quick Charge 2.0|3.0| upto 2000mA"
   echo "3. Toggle Quick Charge 2.0|3.0| upto 1800mA"
   echo "4. Exit                       "
   echo ""
   echo "             Written By                 "
   busybox echo -e "\e[00;44m             TheHitMan            \e[00;37;40m"
   echo "          @xda developers               "
   echo ""
   
   echo -n "Please select an option [1-4]: "
   read option 
   
   if [ $option -eq 1 ]; then
   clear
   echo "- Applying Quick Charge Kernel MOD | upto 2400mA & 3000mA"
   echo " "
   FC="/sys/kernel/fast_charge/force_fast_charge"
   QC="/sys/class/power_supply/battery/allow_hvdcp3"
   if [ -e "$QC" ] || [ -e "$FC" ]; then
       busybox echo -e "\e[00;44m Fast Charge Toggle found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
	   # Fast Charge Toggle
       echo "1" > /sys/kernel/fast_charge/force_fast_charge;
       busybox echo -e "\e[00;44m Quick Charge Toggle found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
	   # Quick Charge Toggle
       echo "1" > /sys/class/power_supply/battery/allow_hvdcp3;
   #
   # dwc3 | overriding default configuration
   if [ -e /sys/module/dwc3/parameters/enable_dwc3_u1u2 ]; then
       busybox echo -e "\e[00;44m enable_dwc3_u1u2 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3/parameters/enable_dwc3_u1u2;
   else
      echo "enable_dwc3_u1u2 not found!"
   fi
   if [ -e /sys/module/dwc3/parameters/high_bw_ep_in_num ]; then
       busybox echo -e "\e[00;44m high_bw_ep_in_num found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3/parameters/high_bw_ep_in_num;
	else
       echo "high_bw_ep_in_num not found!"
   fi
   #
   # dwcm-msm | overriding default configuration
   if [ -e /sys/module/dwc3_msm/parameters/cpu_to_affin ]; then
       busybox echo -e "\e[00;44m cpu_to_affin found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3_msm/parameters/cpu_to_affin;
   else
       echo "cpu_to_affin not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/dcp_max_current ]; then
       busybox echo -e "\e[00;44m dcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "13000" > /sys/module/dwc3_msm/parameters/dcp_max_current;
   else
      echo "dcp_max_current not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/hvdcp_max_current ]; then
       busybox echo -e "\e[00;44m hvdcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "13000" > /sys/module/dwc3_msm/parameters/hvdcp_max_current;
   else
      echo "hvdcp_max_current not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3_msm/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # msm-husb | overriding default configuration
   if [ -e /sys/module/phy_msm_hsusb/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_hsusb/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # msm-qusb | overriding default configuration
   if [ -e /sys/module/phy_msm_qusb/parameters/tune2 ]; then
       busybox echo -e "\e[00;44m etune2 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_qusb/parameters/tune2;
   else
      echo "tune2 not found!"
   fi
   #
   # msm-qusb-v2 | overriding default configuration
   if [ -e /sys/module/phy_msm_qusb_v2/parameters/phy_tune1 ]; then
       busybox echo -e "\e[00;44m phy_tune1 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_qusb_v2/parameters/phy_tune1;
   else
      echo "phy_tune1 not found!"
   fi
   #
   # msm-usb module | overriding default configuration
   if [ -e /sys/module/phy_msm_usb/parameters/dcp_max_current ]; then
       busybox echo -e "\e[00;44m dcp_max_current found...\e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "8000" > /sys/module/phy_msm_usb/parameters/dcp_max_current;
   else
      echo "dcp_max_current not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/floated_charger_enable ]; then
       busybox echo -e "\e[00;44m floated_charger_enable found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_usb/parameters/floated_charger_enable;
   else
      echo "floated_charger_enable not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/hvdcp_max_current ]; then
       busybox echo -e "\e[00;44m hvdcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "15000" > /sys/module/phy_msm_usb/parameters/hvdcp_max_current;
   else
      echo "hvdcp_max_current not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh ]; then
       busybox echo -e "\e[00;44m lpm_disconnect_thresh found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "500" > /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh;
   else
      echo "lpm_disconnect_thresh not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_usb/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # smbcharger-fg module | overriding default configuration
   if [ -e /sys/module/qpnp_fg/parameters/batt_range_pct ]; then
       busybox echo -e "\e[00;44m batt_range_pct found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000000" > /sys/module/qpnp_fg/parameters/batt_range_pct;
   else
       echo "batt_range_pct not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/batt_valid_ocv ]; then
       busybox echo -e "\e[00;44m batt_valid_ocv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/batt_valid_ocv;
   else
       echo "batt_valid_ocv not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/first_est_dump ]; then
       busybox echo -e "\e[00;44m first_est_dump found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/first_est_dump;
   else
       echo "first_est_dump not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/sense_type ]; then
       busybox echo -e "\e[00;44m sense_type found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/sense_type;
   else
       echo "sense_type not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/sram_update_period_ms ]; then
       busybox echo -e "\e[00;44m sram_update_period_ms found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000" > /sys/module/qpnp_fg/parameters/sram_update_period_ms;
   else
       echo "sram_update_period_ms not found!"
   fi
   #
   # smbcharger regulator
   if [ -e /sys/module/qpnp_regulator/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_regulator/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   #
   # qpnp-smbcharger module | overriding default configuration
   if [ -e /sys/module/qpnp_smbcharger/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma ]; then
       busybox echo -e "\e[00;44m default_dcp_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "19000" > /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma;
   else
      echo "default_dcp_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma ]; then
       busybox echo -e "\e[00;44m default_hvdcp_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "19000" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma;
   else
      echo "default_hvdcp_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma ]; then
       busybox echo -e "\e[00;44m default_hvdcp3_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "28000" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma;
   else
      echo "default_hvdcp3_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en ]; then
       busybox echo -e "\e[00;44m dynamic_icl_wipower_en found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en;
   else
      echo "dynamic_icl_wipower_en not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent ]; then
       busybox echo -e "\e[00;44m main_chg_fcc_percent found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "75" > /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent;
   else
      echo "main_chg_fcc_percent not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent ]; then
       busybox echo -e "\e[00;44m main_chg_icl_percent found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "85" > /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent;
   else
      echo "main_chg_icl_percent not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/parallel_en ]; then
       busybox echo -e "\e[00;44m parallel_en found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/parallel_en;
   else
      echo "parallel_en not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua ]; then
       busybox echo -e "\e[00;44m smbchg_ibat_ocp_threshold_ua found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "100000001" > /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua;
   else
      echo "smbchg_ibat_ocp_threshold_ua not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold ]; then
       busybox echo -e "\e[00;44m vf_adjust_high_threshold found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "16" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold;
   else
      echo "vf_adjust_high_threshold not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold ]; then
       busybox echo -e "\e[00;44m vf_adjust_high_threshold found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "4" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold;
   else
      echo "vf_adjust_high_threshold not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv ]; then
       busybox echo -e "\e[00;44m vf_adjust_max_delta_mv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "55" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv;
   else
      echo "vf_adjust_max_delta_mv not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust ]; then
       busybox echo -e "\e[00;44m vf_adjust_trim_steps_per_adjust found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "7" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust;
   else
      echo "vf_adjust_trim_steps_per_adjust not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv ]; then
       busybox echo -e "\e[00;44m wipower_dcin_hyst_uv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "350001" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv;
   else
      echo "wipower_dcin_hyst_uv not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval ]; then
       busybox echo -e "\e[00;44m wipower_dcin_interval found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "8" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval;
   else
      echo "wipower_dcin_interval not found!"
   fi
   #
   #
   # <smb charger>|<battery | power_supply> <Configuration>
   if [ -e /sys/class/power_supply/battery/constant_charge_current_max ]; then
       busybox echo -e "\e[00;44m constant_charge_current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "3000000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/constant_charge_current_max;
   else
      echo "constant_charge_current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging ]; then
       busybox echo -e "\e[00;44m restricted_charging found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging; #Default : 0
   else
      echo "restricted_charging not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled ]; then
       busybox echo -e "\e[00;44m safety_timer_enabled found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled; #Default : 1
   else
      echo "safety_timer_enabled not found!"
   fi
   #
   #
   # <bcl>|<battery_current_limit | power_supply> <Configuration>
   # <bms>|<battery | power_supply> <Configuration>
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection ]; then
       busybox echo -e "\e[00;44m enable_jeita_detection found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection;
   else
      echo "enable_jeita_detection not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power ]; then
       busybox echo -e "\e[00;44m hi_power found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power;
   else
      echo "hi_power not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense ]; then
       busybox echo -e "\e[00;44m ignore_false_negative_isense found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense;
   else
      echo "ignore_false_negative_isense not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool ]; then
       busybox echo -e "\e[00;44m temp_cool found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "290" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool; #Default : 150
   else
      echo "temp_cool not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm ]; then
       busybox echo -e "\e[00;44m temp_warm found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "590" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm; #Default : 450
   else
      echo "temp_warm not found!"
   fi
   #
   #
   # <usb>|<battery | power_supply> <Configuration>
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max ]; then
       busybox echo -e "\e[00;44m current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max
       echo "70000001" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max;
   else
      echo "current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max ]; then
       busybox echo -e "\e[00;44m input_current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max; #0
   else
      echo "input_current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max ]; then
       busybox echo -e "\e[00;44m voltage_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "90000002" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max;
   else
      echo "voltage_max not found!"
   fi
   if [ -f $KA ]; then
      busybox echo -e "\e[00;44m KA bash script found... \e[00;37;40m"
      echo "Applying KA Parameters..."
      sh $KA
   else
      echo "KA Setup not found!"
   fi
   echo " "
   echo "- Quick Charge Kernel MOD Applied | upto 2400mA & 3000mA"
   else
      busybox echo -e "\e[00;41m Fast Charge and Quick Charge toggle not found!!! \e[00;37;40m"
	  busybox echo -e "\e[00;41m Exit now !!! \e[00;37;40m"
   echo "- Quick Charge Kernel MOD Not Applied!!!"
   fi

   elif [ $option -eq 2 ]; then
   clear
   echo "- Applying Quick Charge Kernel MOD | upto 2000mA"
   echo " "
   FC="/sys/kernel/fast_charge/force_fast_charge"
   QC="/sys/class/power_supply/battery/allow_hvdcp3"
   if [ -e "$QC" ] || [ -e "$FC" ]; then
       busybox echo -e "\e[00;44m Fast Charge Toggle found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
	   # Fast Charge Toggle
       echo "1" > /sys/kernel/fast_charge/force_fast_charge;
       busybox echo -e "\e[00;44m Quick Charge Toggle found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
	   # Quick Charge Toggle
       echo "1" > /sys/class/power_supply/battery/allow_hvdcp3;
   #
   # dwc3 | overriding default configuration
   if [ -e /sys/module/dwc3/parameters/enable_dwc3_u1u2 ]; then
       busybox echo -e "\e[00;44m enable_dwc3_u1u2 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3/parameters/enable_dwc3_u1u2;
   else
      echo "enable_dwc3_u1u2 not found!"
   fi
   if [ -e /sys/module/dwc3/parameters/high_bw_ep_in_num ]; then
       busybox echo -e "\e[00;44m high_bw_ep_in_num found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3/parameters/high_bw_ep_in_num;
	else
       echo "high_bw_ep_in_num not found!"
   fi
   #
   # dwcm-msm | overriding default configuration
   if [ -e /sys/module/dwc3_msm/parameters/cpu_to_affin ]; then
       busybox echo -e "\e[00;44m cpu_to_affin found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3_msm/parameters/cpu_to_affin;
   else
       echo "cpu_to_affin not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/dcp_max_current ]; then
       busybox echo -e "\e[00;44m dcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1000" > /sys/module/dwc3_msm/parameters/dcp_max_current;
   else
      echo "dcp_max_current not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/hvdcp_max_current ]; then
       busybox echo -e "\e[00;44m hvdcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1000" > /sys/module/dwc3_msm/parameters/hvdcp_max_current;
   else
      echo "hvdcp_max_current not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3_msm/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # msm-husb | overriding default configuration
   if [ -e /sys/module/phy_msm_hsusb/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_hsusb/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # msm-qusb | overriding default configuration
   if [ -e /sys/module/phy_msm_qusb/parameters/tune2 ]; then
       busybox echo -e "\e[00;44m etune2 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_qusb/parameters/tune2;
   else
      echo "tune2 not found!"
   fi
   #
   # msm-qusb-v2 | overriding default configuration
   if [ -e /sys/module/phy_msm_qusb_v2/parameters/phy_tune1 ]; then
       busybox echo -e "\e[00;44m phy_tune1 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_qusb_v2/parameters/phy_tune1;
   else
      echo "phy_tune1 not found!"
   fi
   #
   # msm-usb module | overriding default configuration
   if [ -e /sys/module/phy_msm_usb/parameters/dcp_max_current ]; then
       busybox echo -e "\e[00;44m dcp_max_current found...\e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1000" > /sys/module/phy_msm_usb/parameters/dcp_max_current;
   else
      echo "dcp_max_current not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/floated_charger_enable ]; then
       busybox echo -e "\e[00;44m floated_charger_enable found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_usb/parameters/floated_charger_enable;
   else
      echo "floated_charger_enable not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/hvdcp_max_current ]; then
       busybox echo -e "\e[00;44m hvdcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1000" > /sys/module/phy_msm_usb/parameters/hvdcp_max_current;
   else
      echo "hvdcp_max_current not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh ]; then
       busybox echo -e "\e[00;44m lpm_disconnect_thresh found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "500" > /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh;
   else
      echo "lpm_disconnect_thresh not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_usb/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # smbcharger-fg module | overriding default configuration
   if [ -e /sys/module/qpnp_fg/parameters/batt_range_pct ]; then
       busybox echo -e "\e[00;44m batt_range_pct found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000000" > /sys/module/qpnp_fg/parameters/batt_range_pct;
   else
       echo "batt_range_pct not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/batt_valid_ocv ]; then
       busybox echo -e "\e[00;44m batt_valid_ocv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/batt_valid_ocv;
   else
       echo "batt_valid_ocv not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/first_est_dump ]; then
       busybox echo -e "\e[00;44m first_est_dump found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/first_est_dump;
   else
       echo "first_est_dump not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/sense_type ]; then
       busybox echo -e "\e[00;44m sense_type found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/sense_type;
   else
       echo "sense_type not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/sram_update_period_ms ]; then
       busybox echo -e "\e[00;44m sram_update_period_ms found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000" > /sys/module/qpnp_fg/parameters/sram_update_period_ms;
   else
       echo "sram_update_period_ms not found!"
   fi
   #
   # smbcharger regulator
   if [ -e /sys/module/qpnp_regulator/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_regulator/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   #
   # qpnp-smbcharger module | overriding default configuration
   if [ -e /sys/module/qpnp_smbcharger/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma ]; then
       busybox echo -e "\e[00;44m default_dcp_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1900" > /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma;
   else
      echo "default_dcp_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma ]; then
       busybox echo -e "\e[00;44m default_hvdcp_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1900" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma;
   else
      echo "default_hvdcp_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma ]; then
       busybox echo -e "\e[00;44m default_hvdcp3_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "2800" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma;
   else
      echo "default_hvdcp3_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en ]; then
       busybox echo -e "\e[00;44m dynamic_icl_wipower_en found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en;
   else
      echo "dynamic_icl_wipower_en not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent ]; then
       busybox echo -e "\e[00;44m main_chg_fcc_percent found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "75" > /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent;
   else
      echo "main_chg_fcc_percent not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent ]; then
       busybox echo -e "\e[00;44m main_chg_icl_percent found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "85" > /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent;
   else
      echo "main_chg_icl_percent not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/parallel_en ]; then
       busybox echo -e "\e[00;44m parallel_en found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/parallel_en;
   else
      echo "parallel_en not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua ]; then
       busybox echo -e "\e[00;44m smbchg_ibat_ocp_threshold_ua found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "100000000" > /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua;
   else
      echo "smbchg_ibat_ocp_threshold_ua not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold ]; then
       busybox echo -e "\e[00;44m vf_adjust_high_threshold found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "16" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold;
   else
      echo "vf_adjust_high_threshold not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold ]; then
       busybox echo -e "\e[00;44m vf_adjust_high_threshold found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "4" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold;
   else
      echo "vf_adjust_high_threshold not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv ]; then
       busybox echo -e "\e[00;44m vf_adjust_max_delta_mv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "55" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv;
   else
      echo "vf_adjust_max_delta_mv not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust ]; then
       busybox echo -e "\e[00;44m vf_adjust_trim_steps_per_adjust found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "7" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust;
   else
      echo "vf_adjust_trim_steps_per_adjust not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv ]; then
       busybox echo -e "\e[00;44m wipower_dcin_hyst_uv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "350000" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv;
   else
      echo "wipower_dcin_hyst_uv not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval ]; then
       busybox echo -e "\e[00;44m wipower_dcin_interval found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "8" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval;
   else
      echo "wipower_dcin_interval not found!"
   fi
   #
   #
   # <smb charger>|<battery | power_supply> <Configuration>
   if [ -e /sys/class/power_supply/battery/constant_charge_current_max ]; then
       busybox echo -e "\e[00;44m constant_charge_current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "2500000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/constant_charge_current_max;
   else
      echo "constant_charge_current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging ]; then
       busybox echo -e "\e[00;44m restricted_charging found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging; #Default : 0
   else
      echo "restricted_charging not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled ]; then
       busybox echo -e "\e[00;44m safety_timer_enabled found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled; #Default : 1
   else
      echo "safety_timer_enabled not found!"
   fi
   #
   #
   # <bcl>|<battery_current_limit | power_supply> <Configuration>
   # <bms>|<battery | power_supply> <Configuration>
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection ]; then
       busybox echo -e "\e[00;44m enable_jeita_detection found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection;
   else
      echo "enable_jeita_detection not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power ]; then
       busybox echo -e "\e[00;44m hi_power found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power;
   else
      echo "hi_power not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense ]; then
       busybox echo -e "\e[00;44m ignore_false_negative_isense found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense;
   else
      echo "ignore_false_negative_isense not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool ]; then
       busybox echo -e "\e[00;44m temp_cool found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "290" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool; #Default : 150
   else
      echo "temp_cool not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm ]; then
       busybox echo -e "\e[00;44m temp_warm found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "590" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm; #Default : 450
   else
      echo "temp_warm not found!"
   fi
   #
   #
   # <usb>|<battery | power_supply> <Configuration>
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max ]; then
       busybox echo -e "\e[00;44m current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max
       echo "70000000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max;
   else
      echo "current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max ]; then
       busybox echo -e "\e[00;44m input_current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max; #0
   else
      echo "input_current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max ]; then
       busybox echo -e "\e[00;44m voltage_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "90000000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max;
   else
      echo "voltage_max not found!"
   fi
   if [ -f $KA ]; then
      busybox echo -e "\e[00;44m KA bash script found... \e[00;37;40m"
      echo "Applying KA Parameters..."
      sh $KA
   else
      echo "KA Setup not found!"
   fi
   echo " "
   echo "- Quick Charge Kernel MOD Applied | upto 2000mA"
   else
      busybox echo -e "\e[00;41m Fast Charge and Quick Charge toggle not found!!! \e[00;37;40m"
	  busybox echo -e "\e[00;41m Exit now !!! \e[00;37;40m"
   echo "- Quick Charge Kernel MOD Not Applied!!!"
   fi
   
   elif [ $option -eq 3 ]; then
   clear
   echo "- Applying Quick Charge Kernel MOD | upto 1800mA"
   echo " "
   FC="/sys/kernel/fast_charge/force_fast_charge"
   QC="/sys/class/power_supply/battery/allow_hvdcp3"
   if [ -e "$QC" ] || [ -e "$FC" ]; then
       busybox echo -e "\e[00;44m Fast Charge Toggle found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
	   # Fast Charge Toggle
       echo "1" > /sys/kernel/fast_charge/force_fast_charge;
       busybox echo -e "\e[00;44m Quick Charge Toggle found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
	   # Quick Charge Toggle
       echo "1" > /sys/class/power_supply/battery/allow_hvdcp3;
   #
   # dwc3 | overriding default configuration
   if [ -e /sys/module/dwc3/parameters/enable_dwc3_u1u2 ]; then
       busybox echo -e "\e[00;44m enable_dwc3_u1u2 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3/parameters/enable_dwc3_u1u2;
   else
      echo "enable_dwc3_u1u2 not found!"
   fi
   if [ -e /sys/module/dwc3/parameters/high_bw_ep_in_num ]; then
       busybox echo -e "\e[00;44m high_bw_ep_in_num found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3/parameters/high_bw_ep_in_num;
	else
       echo "high_bw_ep_in_num not found!"
   fi
   #
   # dwcm-msm | overriding default configuration
   if [ -e /sys/module/dwc3_msm/parameters/cpu_to_affin ]; then
       busybox echo -e "\e[00;44m cpu_to_affin found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3_msm/parameters/cpu_to_affin;
   else
       echo "cpu_to_affin not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/dcp_max_current ]; then
       busybox echo -e "\e[00;44m dcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1500" > /sys/module/dwc3_msm/parameters/dcp_max_current;
   else
      echo "dcp_max_current not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/hvdcp_max_current ]; then
       busybox echo -e "\e[00;44m hvdcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1500" > /sys/module/dwc3_msm/parameters/hvdcp_max_current;
   else
      echo "hvdcp_max_current not found!"
   fi
   if [ -e /sys/module/dwc3_msm/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/dwc3_msm/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # msm-husb | overriding default configuration
   if [ -e /sys/module/phy_msm_hsusb/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_hsusb/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # msm-qusb | overriding default configuration
   if [ -e /sys/module/phy_msm_qusb/parameters/tune2 ]; then
       busybox echo -e "\e[00;44m etune2 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_qusb/parameters/tune2;
   else
      echo "tune2 not found!"
   fi
   #
   # msm-qusb-v2 | overriding default configuration
   if [ -e /sys/module/phy_msm_qusb_v2/parameters/phy_tune1 ]; then
       busybox echo -e "\e[00;44m phy_tune1 found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_qusb_v2/parameters/phy_tune1;
   else
      echo "phy_tune1 not found!"
   fi
   #
   # msm-usb module | overriding default configuration
   if [ -e /sys/module/phy_msm_usb/parameters/dcp_max_current ]; then
       busybox echo -e "\e[00;44m dcp_max_current found...\e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000" > /sys/module/phy_msm_usb/parameters/dcp_max_current;
   else
      echo "dcp_max_current not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/floated_charger_enable ]; then
       busybox echo -e "\e[00;44m floated_charger_enable found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_usb/parameters/floated_charger_enable;
   else
      echo "floated_charger_enable not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/hvdcp_max_current ]; then
       busybox echo -e "\e[00;44m hvdcp_max_current found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1800" > /sys/module/phy_msm_usb/parameters/hvdcp_max_current;
   else
      echo "hvdcp_max_current not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh ]; then
       busybox echo -e "\e[00;44m lpm_disconnect_thresh found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "500" > /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh;
   else
      echo "lpm_disconnect_thresh not found!"
   fi
   if [ -e /sys/module/phy_msm_usb/parameters/override_phy_init ]; then
       busybox echo -e "\e[00;44m override_phy_init found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/phy_msm_usb/parameters/override_phy_init;
   else
      echo "override_phy_init not found!"
   fi
   #
   # smbcharger-fg module | overriding default configuration
   if [ -e /sys/module/qpnp_fg/parameters/batt_range_pct ]; then
       busybox echo -e "\e[00;44m batt_range_pct found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000000" > /sys/module/qpnp_fg/parameters/batt_range_pct;
   else
       echo "batt_range_pct not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/batt_valid_ocv ]; then
       busybox echo -e "\e[00;44m batt_valid_ocv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/batt_valid_ocv;
   else
       echo "batt_valid_ocv not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/first_est_dump ]; then
       busybox echo -e "\e[00;44m first_est_dump found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/first_est_dump;
   else
       echo "first_est_dump not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/sense_type ]; then
       busybox echo -e "\e[00;44m sense_type found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_fg/parameters/sense_type;
   else
       echo "sense_type not found!"
   fi
   if [ -e /sys/module/qpnp_fg/parameters/sram_update_period_ms ]; then
       busybox echo -e "\e[00;44m sram_update_period_ms found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "5000" > /sys/module/qpnp_fg/parameters/sram_update_period_ms;
   else
       echo "sram_update_period_ms not found!"
   fi
   #
   # smbcharger regulator
   if [ -e /sys/module/qpnp_regulator/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_regulator/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   #
   # qpnp-smbcharger module | overriding default configuration
   if [ -e /sys/module/qpnp_smbcharger/parameters/debug_mask ]; then
       busybox echo -e "\e[00;44m debug_mask found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/debug_mask;
   else
       echo "debug_mask not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma ]; then
       busybox echo -e "\e[00;44m default_dcp_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1500" > /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma;
   else
      echo "default_dcp_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma ]; then
       busybox echo -e "\e[00;44m default_hvdcp_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1500" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma;
   else
      echo "default_hvdcp_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma ]; then
       busybox echo -e "\e[00;44m default_hvdcp3_icl_ma found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "2800" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma;
   else
      echo "default_hvdcp3_icl_ma not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en ]; then
       busybox echo -e "\e[00;44m dynamic_icl_wipower_en found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en;
   else
      echo "dynamic_icl_wipower_en not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent ]; then
       busybox echo -e "\e[00;44m main_chg_fcc_percent found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "75" > /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent;
   else
      echo "main_chg_fcc_percent not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent ]; then
       busybox echo -e "\e[00;44m main_chg_icl_percent found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "85" > /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent;
   else
      echo "main_chg_icl_percent not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/parallel_en ]; then
       busybox echo -e "\e[00;44m parallel_en found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "1" > /sys/module/qpnp_smbcharger/parameters/parallel_en;
   else
      echo "parallel_en not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua ]; then
       busybox echo -e "\e[00;44m smbchg_ibat_ocp_threshold_ua found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "100000000" > /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua;
   else
      echo "smbchg_ibat_ocp_threshold_ua not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold ]; then
       busybox echo -e "\e[00;44m vf_adjust_high_threshold found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "16" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold;
   else
      echo "vf_adjust_high_threshold not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold ]; then
       busybox echo -e "\e[00;44m vf_adjust_high_threshold found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "4" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold;
   else
      echo "vf_adjust_high_threshold not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv ]; then
       busybox echo -e "\e[00;44m vf_adjust_max_delta_mv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "55" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv;
   else
      echo "vf_adjust_max_delta_mv not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust ]; then
       busybox echo -e "\e[00;44m vf_adjust_trim_steps_per_adjust found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "7" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust;
   else
      echo "vf_adjust_trim_steps_per_adjust not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv ]; then
       busybox echo -e "\e[00;44m wipower_dcin_hyst_uv found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "350000" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv;
   else
      echo "wipower_dcin_hyst_uv not found!"
   fi
   if [ -e /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval ]; then
       busybox echo -e "\e[00;44m wipower_dcin_interval found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "8" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval;
   else
      echo "wipower_dcin_interval not found!"
   fi
   #
   #
   # <smb charger>|<battery | power_supply> <Configuration>
   if [ -e /sys/class/power_supply/battery/constant_charge_current_max ]; then
       busybox echo -e "\e[00;44m constant_charge_current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "2900000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/constant_charge_current_max;
   else
      echo "constant_charge_current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging ]; then
       busybox echo -e "\e[00;44m restricted_charging found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging; #Default : 0
   else
      echo "restricted_charging not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled ]; then
       busybox echo -e "\e[00;44m safety_timer_enabled found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled; #Default : 1
   else
      echo "safety_timer_enabled not found!"
   fi
   #
   #
   # <bcl>|<battery_current_limit | power_supply> <Configuration>
   # <bms>|<battery | power_supply> <Configuration>
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection ]; then
       busybox echo -e "\e[00;44m enable_jeita_detection found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection;
   else
      echo "enable_jeita_detection not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power ]; then
       busybox echo -e "\e[00;44m hi_power found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power;
   else
      echo "hi_power not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense ]; then
       busybox echo -e "\e[00;44m ignore_false_negative_isense found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense
       echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense;
   else
      echo "ignore_false_negative_isense not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool ]; then
       busybox echo -e "\e[00;44m temp_cool found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "290" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool; #Default : 150
   else
      echo "temp_cool not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm ]; then
       busybox echo -e "\e[00;44m temp_warm found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "590" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm; #Default : 450
   else
      echo "temp_warm not found!"
   fi
   #
   #
   # <usb>|<battery | power_supply> <Configuration>
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max ]; then
       busybox echo -e "\e[00;44m current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max
       echo "70000000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max;
   else
      echo "current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max ]; then
       busybox echo -e "\e[00;44m input_current_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max; #0
   else
      echo "input_current_max not found!"
   fi
   if [ -e /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max ]; then
       busybox echo -e "\e[00;44m voltage_max found... \e[00;37;40m"
	   echo "Applying CVC Parameters..."
       echo "90000000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max;
   else
      echo "voltage_max not found!"
   fi
   if [ -f $KA ]; then
      busybox echo -e "\e[00;44m KA bash script found... \e[00;37;40m"
      echo "Applying KA Parameters..."
      sh $KA
   else
      echo "KA Setup not found!"
   fi
   echo " "
   echo "- Quick Charge Kernel MOD Applied | upto 1800mA"
   else
      busybox echo -e "\e[00;41m Fast Charge and Quick Charge toggle not found!!! \e[00;37;40m"
	  busybox echo -e "\e[00;41m Exit now !!! \e[00;37;40m"
   echo "- Quick Charge Kernel MOD Not Applied!!!"
   fi
   
   #unmount
   elif [ $option -eq 4 ]; then
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
