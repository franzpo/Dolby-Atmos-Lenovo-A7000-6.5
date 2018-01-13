if [ "$DOLBY" == axon7 ]; then
  for FILE in ${CFGS}; do
    sed -i "/proxy { #$MODID/,/} #$MODID/d" $AMLPATH$FILE
  done
  for FILE in ${CFGSXML}; do
    sed -i "/<effectProxy name=\"proxy\" library=\"proxy\" uuid=\"9d4921da-8225-4f29-aefa-6e6f69726861\"><!--$MODID-->/,/<\/effectProxy><!--$MODID-->/d" $AMLPATH$FILE
  done
fi
for FILE in ${CFGS}; do
  sed -i 'H;1h;$!d;x; s/[[:blank:]]*dax {[^{}]*\({[^}]*}[^{}]*\)*}[[:blank:]]*\n//g' $AMLPATH$FILE
  sed -i '/dax {/,/}/d' $AMLPATH$FILE
  sed -i '/dax_sw {/,/}/d' $AMLPATH$FILE
  sed -i '/dax_hw {/,/}/d' $AMLPATH$FILE
done
for FILE in ${CFGSXML}; do
  sed -i '/<!--$MODID-->/d' $AMLPATH$FILE
done
