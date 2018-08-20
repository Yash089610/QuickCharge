#!/system/bin/sh
#==============================================================================
#
#   File Name : ka.sh
#
#   About     : Configure Revolt Kernel.
#
#   Profile   : Balanced | Battery
#
#
#                             Written By
#                             TheHitMan
#                        @xda developers.com
#                           18 August 2018
#==============================================================================

# CRC
chmod 0644 /sys/module/mmc_core/parameters/use_spi_crc
echo "0" > /sys/module/mmc_core/parameters/use_spi_crc;
# SELinux
chmod 0644 /sys/fs/selinux/enforce
echo "0" > /sys/fs/selinux/enforce;
# TCP/IP
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control;
# I/O
chmod 0644 /sys/block/mmcblk0/queue/scheduler
echo "maple" > /sys/block/mmcblk0/queue/scheduler;
# Virtual RAM
/system/bin/swapoff /dev/block/zram0 > /dev/null 2>&1
echo "1" > /sys/block/zram0/reset;
echo "0" > /sys/block/zram0/disksize;
# I/O Notifier
chmod 0644 /sys/module/state_notifier/parameters/enabled
echo "1" > /sys/module/state_notifier/parameters/enabled;
chmod 0444 /sys/module/state_notifier/parameters/enabled
# uKSM
chmod 0644 /sys/kernel/mm/uksm/run
echo "0" > /sys/kernel/mm/uksm/run;
chmod 0644 /sys/kernel/mm/uksm/cpu_governor
echo "quiet" > /sys/kernel/mm/uksm/cpu_governor;
chmod 0644 /sys/kernel/mm/uksm/max_cpu_percentage
echo "0" > /sys/kernel/mm/uksm/max_cpu_percentage;
chmod 0644 /sys/kernel/mm/uksm/sleep_millisecs
echo "0" > /sys/kernel/mm/uksm/sleep_millisecs;
# KSM
chmod 0644 /sys/kernel/mm/ksm/run
echo "0" > /sys/kernel/mm/ksm/run;
chmod 0644 /sys/kernel/mm/ksm/full_scans
echo "0" > /sys/kernel/mm/ksm/full_scans;
chmod 0444 /sys/kernel/mm/ksm/full_scans
echo "0" > /sys/kernel/mm/ksm/sleep_millisecs;
# CPU Boost
chmod 0644 /sys/module/cpu_boost/parameters/input_boost_enabled
echo "0" > /sys/module/cpu_boost/parameters/input_boost_enabled;
chmod 0644 /sys/module/cpu_boost/parameters/input_boost_freq
echo "0" > /sys/module/cpu_boost/parameters/input_boost_freq;
chmod 0644 /sys/module/cpu_boost/parameters/input_boost_ms
echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms;
# Touch Boost
chmod 0644 /sys/module/msm_performance/parameters/touchboost
echo "0" > /sys/module/msm_performance/parameters/touchboost;
# Power Efficient CPU
chmod 0644 /sys/module/workqueue/parameters/power_efficient
echo "0" > /sys/module/workqueue/parameters/power_efficient;
chmod 0444 /sys/module/workqueue/parameters/power_efficient
# s2w - dt2w
chmod 0644 /sys/android_touch/sweep2wake
echo "0" > /sys/android_touch/sweep2wake; #1
chmod 0644 /sys/android_touch/doubletap2wake
echo "0" > /sys/android_touch/doubletap2wake; #2
# GPU Clk Freq.
chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
echo "0" > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost;
chmod 0644 /sys/class/kgsl/kgsl-3d0/deep_nap_timer
echo "1000" > /sys/class/kgsl/kgsl-3d0/deep_nap_timer; #500
chmod 0644 /sys/class/kgsl/kgsl-3d0/max_gpuclk
echo "510000000" > /sys/class/kgsl/kgsl-3d0/max_gpuclk;
chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
echo "133000000" > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq;
chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor;
# Adreno idler
chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_active
echo "1" > /sys/module/adreno_idler/parameters/adreno_idler_active;
chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_idlewait
echo "9" > /sys/module/adreno_idler/parameters/adreno_idler_idlewait;
chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_idleworkload
echo "9000" > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload;
chmod 0644 /sys/module/adreno_idler/parameters/adreno_idler_downdifferential
echo "20" > /sys/module/adreno_idler/parameters/adreno_idler_downdifferential;
# fsync
chmod 0644 /sys/module/sync/parameters/fsync_enabled
echo "0" > /sys/module/sync/parameters/fsync_enabled;
chmod 0444 /sys/module/sync/parameters/fsync_enabled
# Vibration Strength - Default 83%
chmod 0644 /sys/class/timed_output/vibrator/vtg_level
echo "3004" > /sys/class/timed_output/vibrator/vtg_level;
#Little CPUs
chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq;
chmod 0644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq;
chmod 0644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq;
chmod 0644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq;
# Big CPUs
chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq;
chmod 0644 /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq;
chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq;
chmod 0644 /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
echo "1401600" > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq;
chmod 0644 /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
echo "652800" > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq;
# Hostname
setprop net.hostname android
