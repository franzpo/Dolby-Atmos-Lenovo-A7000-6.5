for CFG in $CONFIG_FILE $HTC_CONFIG_FILE $OTHER_V_FILE $OFFLOAD_CONFIG $V_CONFIG_FILE; do
  if [ -f $CFG ]; then
    sed -i 'H;1h;$!d;x; s/[[:blank:]]*dax {[^{}]*\({[^}]*}[^{}]*\)*}[[:blank:]]*\n//g' $AMLPATH$CFG
    sed -i '/dax {/,/}/d' $AMLPATH$CFG
    sed -i '/dax_sw {/,/}/d' $AMLPATH$CFG
    sed -i '/dax_hw {/,/}/d' $AMLPATH$CFG
  fi
done
