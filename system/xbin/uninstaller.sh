#!/system/bin/sh
#==============================================================================
#
#   File Name : uninstaller.sh
#
#   About     : Reset and Uninstall Revolt Kernel Quick Charge MOD.
#
#
#                             Written By
#                             TheHitMan
#                        @xda developers.com
#                           18 August 2018
#==============================================================================

echo "- Applying Quick Charge Reset"
sleep 4
echo "0" > /sys/kernel/fast_charge/force_fast_charge;
echo "0" > /sys/class/power_supply/battery/allow_hvdcp3;
echo "0" > /sys/module/dwc3/parameters/enable_dwc3_u1u2;
echo "0" > /sys/module/dwc3_msm/parameters/override_phy_init;
echo "0" > /sys/module/phy_msm_hsusb/parameters/override_phy_init;
echo "0" > /sys/module/phy_msm_qusb/parameters/tune2;
echo "0" > /sys/module/phy_msm_qusb_v2/parameters/phy_tune1;
echo "1000" > /sys/module/phy_msm_usb/parameters/dcp_max_current;
echo "1000" > /sys/module/phy_msm_usb/parameters/hvdcp_max_current;
echo "1000" > /sys/module/phy_msm_usb/parameters/lpm_disconnect_thresh;
echo "null" > /sys/module/phy_msm_usb/parameters/override_phy_init;
echo "1000" > /sys/module/dwc3_msm/parameters/dcp_max_current;
echo "1000" > /sys/module/dwc3_msm/parameters/hvdcp_max_current;
echo "1000" > /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma;
echo "1000" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma;
echo "500" > /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma;
echo "0" > /sys/module/qpnp_smbcharger/parameters/parallel_en;
echo "0" > /sys/module/phy_msm_usb/parameters/floated_charger_enable;
echo "4500000" > /sys/module/qpnp_smbcharger/parameters/smbchg_ibat_ocp_threshold_ua;
echo "7" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_high_threshold;
echo "5" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_low_threshold;
echo "40" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_max_delta_mv;
echo "1" > /sys/module/qpnp_smbcharger/parameters/vf_adjust_trim_steps_per_adjust;
echo "250000" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_hyst_uv;
echo "2" > /sys/module/qpnp_smbcharger/parameters/wipower_dcin_interval;
echo "0" > /sys/module/qpnp_smbcharger/parameters/dynamic_icl_wipower_en;
echo "50" > /sys/module/qpnp_smbcharger/parameters/main_chg_fcc_percent;
echo "60" > /sys/module/qpnp_smbcharger/parameters/main_chg_icl_percent;
echo "2000000" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/constant_charge_current_max;
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/restricted_charging; #Default : 0
echo "1" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/safety_timer_enabled; #Default : 1
chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/enable_jeita_detection;
chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/hi_power;
chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/ignore_false_negative_isense;
echo "150" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_cool; #Default : 150
echo "450" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/bms/temp_warm; #Default : 450
chmod 0664 /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/current_max;
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/input_current_max; #0
echo "0" > /sys/devices/soc/qpnp-smbcharger-18/power_supply/battery/subsystem/usb/voltage_max;
echo "0" > /sys/module/dwc3/parameters/high_bw_ep_in_num;
echo "0" > /sys/module/dwc3_msm/parameters/cpu_to_affin;
echo "0" > /sys/module/qpnp_fg/parameters/batt_range_pct;
echo "0" > /sys/module/qpnp_fg/parameters/batt_valid_ocv;
echo "0" > /sys/module/qpnp_fg/parameters/debug_mask;
echo "0" > /sys/module/qpnp_fg/parameters/first_est_dump;
echo "0" > /sys/module/qpnp_fg/parameters/sense_type;
echo "0" > /sys/module/qpnp_fg/parameters/sram_update_period_ms;
echo "0" > /sys/module/qpnp_smbcharger/parameters/debug_mask;
echo "0" > /sys/module/qpnp_regulator/parameters/debug_mask;
echo "- Done"
echo $divider
echo "- Uninstalling Quick Charge Files"
sleep 4
busybox rm -rf /system/xbin/run.sh
busybox rm -rf /system/xbin/charging_controller.sh
busybox rm -rf /system/xbin/get_cvc_info.sh
busybox rm -rf /system/xbin/ka_tweaks.sh
busybox rm -rf /system/xbin/test.sh
echo "- Done"
