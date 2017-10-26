ui_print "    Patching existing audio_effects files..."
if [ "$DOLBY" == a7000-6.5 ] || [ "$DOLBY" == aquax5 ] || [ "$DOLBY" == lemax2 ] || [ "$DOLBY" == lepro3 ]; then
  for CFG in $CONFIG_FILE $HTC_CONFIG_FILE $OTHER_V_FILE $OFFLOAD_CONFIG $V_CONFIG_FILE; do
    if [ -f $CFG ] && [ ! "$(cat $AMLPATH$CFG | grep ' dax {')" ]; then
	  sed -i 's/^effects {/effects {\n  dax {\n    library dax\n    uuid 9d4921da-8225-4f29-aefa-6e6f69726861\n  }/g' $AMLPATH$CFG
	  sed -i 's/^libraries {/libraries {\n  dax {\n    path \/system\/lib\/soundfx\/libswdax.so\n  }/g' $AMLPATH$CFG
    fi
  done
fi
if [ "$DOLBY" == axon7 ]; then
  for CFG in $CONFIG_FILE $HTC_CONFIG_FILE $OTHER_V_FILE $OFFLOAD_CONFIG $V_CONFIG_FILE; do
    if [ -f $CFG ] && [ ! "$(cat $AMLPATH$CFG | grep ' dax {')" ]; then
	  sed -i 's/^effects {/effects {\n  dax {\n    library proxy\n    uuid 9d4921da-8225-4f29-aefa-6e6f69726861\n\n    libsw {\n      library dax_sw\n      uuid 6ab06da4-c516-4611-8166-6168726e6f69\n    }\n\n    libhw {\n      library dax_hw\n      uuid a0c30891-8246-4aef-b8ad-696f6e726861\n    }\n  }/g' $AMLPATH$CFG
	  sed -i 's/^libraries {/libraries {\n  dax_hw {\n    path \/system\/lib\/soundfx\/libhwdax.so\n  }/g' $AMLPATH$CFG
	  sed -i 's/^libraries {/libraries {\n  dax_sw {\n    path \/system\/lib\/soundfx\/libswdax.so\n  }/g' $AMLPATH$CFG
    fi
  done
fi
  