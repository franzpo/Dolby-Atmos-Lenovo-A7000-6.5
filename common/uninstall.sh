$MAGISK || { for FILE in ${CFGS}; do
               case $FILE in
                 *.conf) [ "$DOLBY" == "axon7" ] && sed -i "/proxy { #$MODID/,/} #$MODID/d" $UNITY$FILE
                         sed -i 'H;1h;$!d;x; s/[[:blank:]]*dax {[^{}]*\({[^}]*}[^{}]*\)*}[[:blank:]]*\n//g' $UNITY$FILE
                         sed -i '/dax {/,/}/d' $UNITY$FILE
                         sed -i '/dax_sw {/,/}/d' $UNITY$FILE
                         sed -i '/dax_hw {/,/}/d' $UNITY$FILE;;
                 *.xml) [ "$DOLBY" == "axon7" ] && sed -i "/<effectProxy name=\"proxy\" library=\"proxy\" uuid=\"9d4921da-8225-4f29-aefa-6e6f69726861\"><!--$MODID-->/,/<\/effectProxy><!--$MODID-->/d" $UNITY$FILE
                        sed -i '/<!--$MODID-->/d' $UNITY$FILE;;
               esac
             done }
