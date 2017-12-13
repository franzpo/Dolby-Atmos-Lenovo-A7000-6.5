ui_print "    Patching existing audio_effects files..."
if [ "$DOLBY" == a7000-6.5 ] || [ "$DOLBY" == aquax5 ] || [ "$DOLBY" == lemax2 ] || [ "$DOLBY" == lepro3 ]; then
  for FILE in ${CFGS}; do
    if [ ! "$(grep "dax" $AMLPATH$FILE)" ]; then
      sed -i "s/^effects {/effects {\n  dax {\n    library dax\n    uuid 9d4921da-8225-4f29-aefa-6e6f69726861\n  }/g" $AMLPATH$FILE
      sed -i "s/^libraries {/libraries {\n  dax {\n    path $LIBPATCH\/lib\/soundfx\/libswdax.so\n  }/g" $AMLPATH$FILE
    fi
  done
  for FILE in ${CFGSXML}; do
    if [ ! "$(grep "dax" $AMLPATH$FILE)" ]; then
      sed -i "/<libraries>/ a\        <library name=\"dax\" path=\"libswdax.so\"\/><!--$MODID-->" $AMLPATH$FILE
      sed -i "/<effects>/ a\        <effect name=\"dax\" library=\"dax\" uuid=\"9d4921da-8225-4f29-aefa-6e6f69726861\"\/><!--$MODID-->" $AMLPATH$FILE
    fi
  done
fi
if [ "$DOLBY" == axon7 ]; then
  for FILE in ${CFGS}; do
    if [ ! "$(grep "dax" $AMLPATH$FILE)" ]; then
      if [ ! "$(grep '^ *proxy {' $AMLPATH$FILE)" ]; then
        sed -i "s/^libraries {/libraries {\n  proxy { #$MODID\n    path $LIBPATCH\/lib\/soundfx\/libeffectproxy.so\n  } #$MODID/g" $AMLPATH$FILE
      fi
      if [ ! "$(grep "dax" $AMLPATH$FILE)" ]; then
        sed -i "s/^effects {/effects {\n  dax {\n    library proxy\n    uuid 9d4921da-8225-4f29-aefa-6e6f69726861\n\n    libsw {\n      library dax_sw\n      uuid 6ab06da4-c516-4611-8166-6168726e6f69\n    }\n\n    libhw {\n      library dax_hw\n      uuid a0c30891-8246-4aef-b8ad-696f6e726861\n    }\n  }/g" $AMLPATH$FILE
        sed -i "s/^libraries {/libraries {\n  dax_hw {\n    path $LIBPATCH\/lib\/soundfx\/libhwdax.so\n  }/g" $AMLPATH$FILE
        sed -i "s/^libraries {/libraries {\n  dax_sw {\n    path $LIBPATCH\/lib\/soundfx\/libswdax.so\n  }/g" $AMLPATH$FILE
      fi
    fi
  done
  for FILE in ${CFGSXML}; do
    if [ ! "$(grep "dax" $AMLPATH$FILE)" ]; then
      if [ ! "$(grep "<library name=\"proxy\" path=\"libeffectproxy.so\"\/>" $AMLPATH$FILE)" ]; then
        sed -i "/<libraries>/ a\        <library name=\"proxy\" path=\"libeffectproxy.so\"\/><!--$MODID-->" $AMLPATH$FILE
      fi
      if [ ! "$(grep "dax" $AMLPATH$FILE)" ]; then
        sed -i "/<libraries>/ a\        <library name=\"dax_hw\" path=\"libhwdax.so\"\/><!--$MODID-->" $AMLPATH$FILE
        sed -i "/<libraries>/ a\        <library name=\"dax_sw\" path=\"libswdax.so\"\/><!--$MODID-->" $AMLPATH$FILE        
        sed -i -e "/<effects>/ a\        <effectProxy name=\"proxy\" library=\"proxy\" uuid=\"9d4921da-8225-4f29-aefa-6e6f69726861\"><!--$MODID-->" -e "/<effects>/ a\            <libsw library=\"dax_sw\" uuid=\"6ab06da4-c516-4611-8166-6168726e6f69\"\/>" -e "/<effects>/ a\            <libhw library=\"dax_hw\" uuid=\"a0c30891-8246-4aef-b8ad-696f6e726861\"\/>" -e "/<effects>/ a\        <\/effectProxy><!--$MODID-->" $AMLPATH$FILE
      fi
    fi
  done
fi
