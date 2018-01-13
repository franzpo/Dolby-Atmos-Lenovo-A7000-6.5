TIMEOFEXEC=1

# Temp fix for oos oreo devices
if $OREONEW && [ "$(grep_prop ro.product.brand)" == "OnePlus" ]; then
  ui_print "   ! Oneplus Oreo device detected !"
  ui_print "   Setting selinux to permissive..."
  if $MAGISK; then echo "#!/system/bin/sh" > $INSTALLER/common/unity-audmodlib/$MODID-post-fs-data.sh; else echo "$SHEBANG" > $INSTALLER/common/unity-audmodlib/$MODID-post-fs-data.sh; fi
  echo "setenforce 0" >> $INSTALLER/common/unity-audmodlib/$MODID-post-fs-data.sh
fi

if [ "$DOLBY" != axon7 ] && [ "$DOLBY" != a7000-6.5 ]; then
  
  # GET OLD/NEW FROM ZIP NAME
  case $(basename $ZIP) in
    *old*|*Old*|*OLD*) UI=21;;
    *new*|*New*|*NEW*) UI=42;;
  esac

  # Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
  KEYCHECK=$INSTALLER/common/keycheck
  chmod 755 $KEYCHECK

  chooseport() {
    $KEYCHECK
    INPUT=$?
    if [[ $INPUT -eq 42 ]] || [[ $INPUT -eq 21 ]]; then
      UI=$INPUT
    else
      ui_print "Unrecognized key! Using old ui"
      UI=21
    fi
    shift
  }

  ui_print " "
  ui_print "- Select Version -"
  if [ -z $UI ]; then
    ui_print "   Choose which dolby ui you want installed:"
    ui_print "   Vol+ = new, Vol- = old"
    chooseport
  else
    ui_print "   Dolby ui version specified in zipname!"
  fi
  if [[ $UI -eq 42 ]]; then
    ui_print "   New ui will be installed"
    cp -f $INSTALLER/custom/AxUI.apk $INSTALLER/system/app/AxUI/AxUI.apk
  else
    ui_print "  Old ui will be installed"
  fi
fi
  