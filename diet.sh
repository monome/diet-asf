#!/bin/bash
set -e

OS=`uname | tr '[A-Z]' '[a-z]'`
ASF_DIR="xdk-asf-3.30.0"
ASF_ZIP="archive/asf-standalone-archive-3.30.0.43.zip"

# we need to add -r to GNU xargs
find-rm() {
    case $OS in
        darwin) find ./asf -name $1 -type d -print0 | xargs -0 rm -r ;;
        linux)  find ./asf -name $1 -type d -print0 | xargs -r -0 rm -r ;;
    esac
}

if [[ ! -f $ASF_ZIP ]]; then
    cat $ASF_ZIP.* > $ASF_ZIP
fi

if [[ -d $ASF_DIR ]]; then
    echo "Removing existing $ASF_DIR directory"
    rm -r $ASF_DIR
fi

if [[ -d asf ]]; then
    echo "Removing existing asf directory"
    rm -r asf
fi

shasum -c SHA256SUMS
echo "SHA256 sums check"

# unzip has problems with the zip file!
7z x $ASF_ZIP 1>/dev/null
mv $ASF_DIR asf

echo "Size of asf"
du -hs asf

echo
echo "Pruning"

rm    asf/asf-releasenotes-3.30.0.pdf
rm -r asf/avr32/applications
rm -r asf/avr32/boards
rm -r asf/avr32/components/accelerometer
rm -r asf/avr32/components/audio
rm -r asf/avr32/components/clocks
rm -r asf/avr32/components/display
rm -r asf/avr32/components/ethernet_phy
rm -r asf/avr32/components/joystick
rm -r asf/avr32/components/memory/eeprom
rm -r asf/avr32/components/memory/nand_flash
rm -r asf/avr32/components/memory/sd_mmc/sd_mmc_mci
rm -r asf/avr32/components/touch
rm -r asf/avr32/drivers/abdac
rm -r asf/avr32/drivers/acifa
rm -r asf/avr32/drivers/acifb
rm -r asf/avr32/drivers/adcifa
rm -r asf/avr32/drivers/adcifb
rm -r asf/avr32/drivers/aes
rm -r asf/avr32/drivers/ast
rm -r asf/avr32/drivers/canif
rm -r asf/avr32/drivers/cpu/mpu
rm -r asf/avr32/drivers/cpu/sau
rm -r asf/avr32/drivers/dacifb
rm -r asf/avr32/drivers/dmaca
rm -r asf/avr32/drivers/ebi/sdramc
rm -r asf/avr32/drivers/ecchrs
rm -r asf/avr32/drivers/flashcdw
rm -r asf/avr32/drivers/freqm
rm -r asf/avr32/drivers/hmatrix
rm -r asf/avr32/drivers/iisc
rm -r asf/avr32/drivers/macb
rm -r asf/avr32/drivers/mci
rm -r asf/avr32/drivers/mdma
rm -r asf/avr32/drivers/pevc
rm -r asf/avr32/drivers/pm/pm_uc3*
rm -r asf/avr32/drivers/pwm
rm -r asf/avr32/drivers/pwma
rm -r asf/avr32/drivers/qdec
rm -r asf/avr32/drivers/rtc
rm -r asf/avr32/drivers/scif
rm -r asf/avr32/drivers/ssc
rm -r asf/avr32/drivers/twim
rm -r asf/avr32/drivers/twis
rm -r asf/avr32/drivers/usbc
rm -r asf/avr32/drivers/wdt
rm -r asf/avr32/services/audio
rm -r asf/avr32/services/dsp
rm -r asf/avr32/services/freq_detect
rm -r asf/avr32/services/network
rm -r asf/avr32/services/storage
rm -r asf/avr32/services/usb
rm    asf/avr32/utils/header_files/avr32-headers.zip
rm -r asf/avr32/utils/libs
rm -r asf/avr32/utils/linker_scripts
rm -r asf/common/applications
rm -r asf/common/boards/user_board
rm -r asf/common/components
rm -r asf/common/drivers
rm -r asf/common/services/adp
rm -r asf/common/services/calendar
rm -r asf/common/services/clock/uc3a3_a4
rm -r asf/common/services/clock/uc3c
rm -r asf/common/services/clock/uc3d
rm -r asf/common/services/clock/uc3l
rm -r asf/common/services/cpu
rm -r asf/common/services/crc32
rm -r asf/common/services/fifo
rm -r asf/common/services/gpio
rm -r asf/common/services/hugemem
rm -r asf/common/services/ioport
rm -r asf/common/services/isp
rm -r asf/common/services/freertos
rm -r asf/common/services/gfx
rm -r asf/common/services/gfx_mono
rm -r asf/common/services/sensors
rm -r asf/common/services/serial
rm -r asf/common/services/sleepmgr
rm -r asf/common/services/storage/ecc_hamming
rm -r asf/common/services/twi
rm -r asf/common/services/usb/class/dfu_flip
rm -r asf/common/services/usb/manual
rm -r asf/common/services/wtk
rm -r asf/common2
rm -r asf/mega
rm -r asf/sam
rm -r asf/sam0
rm -r asf/thirdparty
rm -r asf/xmega

find-rm "mega*"
find-rm "sam*"
find-rm "xmega*"
find-rm "iar"
find-rm "doxygen"
find-rm "example"
find-rm "examples"
find-rm "*_example"
find-rm "*_examples"
find-rm "example_*"
find-rm "examples_*"
find-rm "example[0-9]*"
find-rm "*example[0-9]"
find-rm "unit_tests"
find-rm "*xplained"
find-rm "_asf_v1"

patch asf/avr32/drivers/usbb/usbb_host.c patches/usbb_host.patch
patch asf/common/services/clock/uc3b0_b1/pll.h patches/pll.patch
patch asf/common/boards/board.h patches/board.patch

echo "Pruned size of asf"
du -hs asf

