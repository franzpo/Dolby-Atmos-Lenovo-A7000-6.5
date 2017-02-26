#!/system/bin/sh

LOG_FILE=/data/local/dax_run.log;

# VENDOR SPECIFIC DOLBY ATMOS TWEAKS
setprop dmid 3067269873
setprop audio.ds1.metainfo.key 273
setprop audio.dolby.ds2.enabled true
setprop audio.dolby.ds2.hardbypass true
setprop dolby.audio.sink.info speaker
setprop dolby.ds.dialogenhancer.state on
setprop dolby.ds.graphiceq.state on
setprop dolby.ds.intelligenteq.preset ieq_on
setprop dolby.ds.intelligenteq.state on
setprop dolby.ds.profile.name Music
setprop dolby.ds.state on
setprop dolby.ds.virt.bluetooth on
setprop dolby.ds.virt.hdmi on
setprop dolby.ds.virt.headphone_port on
setprop dolby.ds.virt.internal_speaker on
setprop dolby.ds.virt.miracast on
setprop dolby.ds.virt.usb on
setprop dolby.ds.volumeleveler.state off
setprop dolby.monospeaker false
setprop ro.lenovo.soundeffect dolby
setprop ro.mtk_dolby_dap_support 1

if [ -e /data/local/dax_run.log ]; then
    rm /data/local/dax_run.log
fi
echo "Dolby Atmos script has run successfully $(date +"%m-%d-%Y %H:%M:%S")" | tee -a $LOG_FILE;

# KEEP DOLBY ATMOS IN MEMORY
setprop sys.keep_app_2 com.atmos
PPID=$(pidof com.atmos)
echo "-17" > /proc/$PPID/oom_adj
renice -18 $PPID


# SCRIPT BY ahrion@XDA
# DO NOT STEAL