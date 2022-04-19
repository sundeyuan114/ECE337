#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Sun Apr 10 17:56:07 2022                
#                                                     
#######################################################

#@(#)CDS: Innovus v16.12-s051_1 (64bit) 08/17/2016 12:18 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute 16.12-s051_1 NR160816-1350/16_12-UB (database version 2.30, 347.6.1) {superthreading v1.30}
#@(#)CDS: AAE 16.12-s026 (64bit) 08/17/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 16.12-s023_1 () Aug 12 2016 01:35:46 ( )
#@(#)CDS: SYNTECH 16.12-s009_1 () Aug 11 2016 01:33:09 ( )
#@(#)CDS: CPE v16.12-s054
#@(#)CDS: IQRC/TQRC 15.2.4-s467 (64bit) Wed Jul 20 17:12:38 PDT 2016 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
getDrawView
loadWorkspace -name Physical
win
set ::TimeLib::tsgMarkCellLatchConstructFlag 1
set conf_qxconf_file NULL
set conf_qxlib_file NULL
set defHierChar /
set delaycal_input_transition_delay 0.1ps
set distributed_client_message_echo 1
set distributed_mmmc_disable_reports_auto_redirection 0
set floorplan_default_site core
set fpIsMaxIoHeight 0
set init_gnd_net gnd
set init_io_file innovus.io
set init_lef_file {/package/eda/cells/OSU/v2.7/cadence/lib/ami05/lib/osu05_stdcells.lef /package/eda/cells/OSU/v2.7/cadence/lib/ami05/lib/osu05_stdcells.stacks.lef}
set init_mmmc_file osu05_MMMC.view
set init_oa_search_lib {}
set init_pwr_net vdd
set init_verilog mapped/layout_lab_design.v
set latch_time_borrow_mode max_borrow
set pegDefaultResScaleFactor 1
set pegDetailResScaleFactor 1
set report_inactive_arcs_format {from to when arc_type sense reason}
set timing_library_ccs_noise_vin_clip_points {}
set timing_library_ccs_noise_vout_clip_points {}
set timing_library_load_pin_cap_indices {}
set timing_library_write_library_to_directory {}
set tso_post_client_restore_command {update_timing ; write_eco_opt_db ;}
init_design
floorPlan -r 1.0 0.6 50 50 50 50
unfixAllIos
legalizePin
addRing -spacing_bottom 9.9 -width_left 9.9 -width_bottom 9.9 -width_top 9.9 -spacing_top 9.9 -layer_bottom metal1 -width_right 9.9 -around default_power_domain -center 1 -layer_top metal1 -spacing_right 9.9 -spacing_left 9.9 -layer_right metal2 -layer_left metal2 -offset 9.9 -nets { gnd vdd }
selectWire 310.3500 1170.4500 1189.6500 1180.3500 1 vdd
deselectAll
selectWire 330.1500 1150.6500 1169.8500 1160.5500 1 gnd
deselectAll
selectWire 330.1500 330.4500 340.0500 1160.5500 2 gnd
deselectAll
selectWire 310.3500 310.6500 320.2500 1180.3500 2 vdd
deselectAll
selectWire 310.3500 1170.4500 1189.6500 1180.3500 1 vdd
deselectAll
selectWire 330.1500 1150.6500 1169.8500 1160.5500 1 gnd
deselectAll
selectWire 330.1500 330.4500 340.0500 1160.5500 2 gnd
deselectAll
selectWire 310.3500 310.6500 320.2500 1180.3500 2 vdd
deselectAll
selectWire 330.1500 330.4500 340.0500 1160.5500 2 gnd
deselectAll
selectWire 330.1500 1150.6500 1169.8500 1160.5500 1 gnd
deselectAll
selectWire 310.3500 1170.4500 1189.6500 1180.3500 1 vdd
deselectAll
selectWire 330.1500 330.4500 340.0500 1160.5500 2 gnd
deselectAll
setPlaceMode -congEffort medium
placeDesign -inPlaceOpt
checkPlace
sroute
selectInst P3
deselectAll
zoomBox 1581.425 718.837 1548.521 762.024
trialRoute
timeDesign -preCTS
selectInst FE1
deselectAll
selectWire 446.8500 717.7500 592.3500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 552.4500 699.7500 585.1500 701.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN20_n79
deselectAll
selectWire 586.0500 693.7500 645.1500 695.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n8
deselectAll
selectWire 571.6500 690.7500 618.7500 692.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n210
deselectAll
selectWire 583.6500 699.7500 647.5500 701.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN20_n79
deselectAll
selectWire 571.9500 616.0500 572.8500 691.9500 2 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n210
deselectAll
selectWire 634.0500 690.7500 705.1500 692.2500 3 {I0/LD/T_FIFO/IP_FIFO/UFIFORAM/fiforeg[6][3]}
deselectAll
selectWire 643.6500 693.7500 676.3500 695.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n8
deselectAll
selectWire 583.6500 699.7500 647.5500 701.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN20_n79
deselectAll
selectWire 622.0500 717.7500 700.3500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 650.8500 723.7500 681.1500 725.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n100
deselectAll
selectWire 689.5500 667.0500 690.4500 742.9500 2 {I0/LD/read_data_int[4]}
deselectAll
selectWire 638.8500 753.7500 724.3500 755.2500 3 I0/LD/n3
deselectAll
selectWire 679.6500 747.7500 736.3500 749.2500 3 nclk
deselectAll
selectWire 694.3500 754.0500 695.2500 787.9500 2 nn_rst
deselectAll
selectWire 679.6500 783.7500 757.9500 785.2500 3 I0/LD/T_SR_0/n23
deselectAll
selectWire 756.4500 705.7500 767.5500 707.2500 3 {I0/LD/T_FIFO/IP_FIFO/UFIFORAM/fiforeg[4][4]}
deselectAll
selectWire 759.1500 700.0500 760.0500 721.9500 2 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN14_n19
deselectAll
selectWire 734.8500 693.7500 772.3500 695.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n182
deselectAll
selectWire 727.6500 681.7500 815.5500 683.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN4_raddr_0
deselectAll
selectWire 350.4000 680.1000 1149.6000 681.9000 1 gnd
deselectAll
selectWire 679.6500 651.7500 777.1500 653.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN5_n18
deselectAll
selectWire 727.6500 639.7500 803.5500 641.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n211
deselectAll
selectWire 732.4500 642.7500 813.1500 644.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n212
deselectAll
selectWire 725.2500 636.7500 760.3500 638.2500 3 {I0/LD/T_FIFO/IP_FIFO/UFIFORAM/fiforeg[0][4]}
deselectAll
selectWire 571.9500 616.0500 572.8500 691.9500 2 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n210
deselectAll
selectWire 350.4000 680.1000 1149.6000 681.9000 1 gnd
deselectAll
selectWire 595.6500 672.7500 623.5500 674.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n180
deselectAll
selectWire 526.0500 684.7500 657.1500 686.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN18_n60
deselectAll
selectWire 571.6500 690.7500 618.7500 692.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n210
deselectAll
selectWire 586.0500 693.7500 645.1500 695.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n8
deselectAll
selectWire 591.1500 607.0500 592.0500 718.9500 2 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 583.6500 699.7500 647.5500 701.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN20_n79
deselectAll
selectWire 593.2500 735.7500 611.5500 737.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n116
deselectAll
selectWire 593.2500 726.7500 621.1500 728.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n45
deselectAll
selectWire 610.0500 723.7500 618.7500 725.2500 3 {I0/LD/T_FIFO/IP_FIFO/UFIFORAM/fiforeg[4][3]}
deselectAll
selectWire 590.8500 717.7500 623.5500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 622.0500 717.7500 700.3500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 350.4000 710.1000 1149.6000 711.9000 1 vdd
deselectAll
selectWire 622.0500 717.7500 700.3500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 701.2500 723.7500 736.3500 725.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n46
deselectAll
selectWire 703.6500 729.7500 757.9500 731.2500 3 {I0/LD/T_FIFO/IP_FIFO/UFIFORAM/fiforeg[4][4]}
deselectAll
selectWire 727.6500 726.7500 791.5500 728.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n10
deselectAll
selectWire 761.2500 723.7500 798.7500 725.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n24
deselectAll
selectWire 432.4500 717.7500 445.9500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
gui_select -rect {457.924 714.476 454.899 721.256}
zoomBox 454.899 727.096 454.169 731.164
gui_select -rect {454.858 728.445 454.821 728.682}
selectWire 727.6500 726.7500 791.5500 728.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n10
deselectAll
selectWire 446.8500 717.7500 592.3500 719.2500 3 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN16_n41
deselectAll
selectWire 586.3500 694.0500 587.2500 730.9500 2 I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n8
deselectAll
selectWire 576.7500 676.0500 577.6500 751.9500 2 {I0/LD/read_data_int[3]}
deselectAll
selectWire 689.5500 667.0500 690.4500 742.9500 2 {I0/LD/read_data_int[4]}
deselectAll
selectWire 689.5500 667.0500 700.0500 667.9500 2 {I0/LD/read_data_int[4]}
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -preCTS -drv
trialRoute
timeDesign -postCTS
setExtractRCMode -assumeMetFill
extractRC -outfile encounter.cap
setOptMode -yieldEffort none
setOptMode -highEffort
setOptMode -maxDensity 0.95
setOptMode -drcMargin 0.0
setOptMode -holdTargetSlack 0.0 -setupTargetSlack 0.0
setOptMode -noSimplifyNetlist
optDesign -postCTS -hold
optDesign -postCTS -drv
all_hold_analysis_views
all_setup_analysis_views
getPlaceMode -doneQuickCTS -quiet
addFiller -cell FILL
globalNetConnect vdd -type tiehi
globalNetConnect vdd -type pgpin -pin vdd -all -override
globalNetConnect gnd -type tielo
globalNetConnect gnd -type pgpin -pin gnd -all -override
sroute
globalDetailRoute
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -postRoute -pathReports -drvReports -slackReports -numPaths 50 -prefix lab7_layout_design_post -outDir timingReports
get_time_unit
report_timing -machine_readable -max_points 10000 -max_slack 0.75 -path_exceptions all > top.mtarpt
load_timing_debug_report -name default_report top.mtarpt
uiKit::addWidget .dodo -type main
uiKit::addWidget gtd@frameOnly_detail -type main
uiKit::addWidget sgnviewer_tdg_frame -type main -closecmd {::sgn::quitApply sgnviewer_tdg_frame}
uiKit::addWidget sgnviewer_tdg_frame.ib -type statusbar -in sgnviewer_tdg_frame
uiKit::addWidget sgnviewer_tdg_frame.msg -type message -variable ::csv::infoMsg(sgnviewer_tdg_frame) -stretch 1
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFC8_n29
zoomSelected
editSelect -net I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFN8_n29
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/U234
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/U71
zoomSelected
editSelect -net I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n40
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFC8_n29
zoomSelected
selectInst {I0/LD/T_FIFO/IP_FIFO/UWFC/waddr_reg[1]}
zoomSelected
editSelect -net {I0/LD/T_FIFO/IP_FIFO/waddr[1]}
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/U71
zoomSelected
selectInst {I0/LD/T_FIFO/IP_FIFO/UWFC/waddr_reg[1]}
zoomSelected
editSelect -net {I0/LD/T_FIFO/IP_FIFO/waddr[1]}
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/U71
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/U71
zoomSelected
editSelect -net I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n40
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/FE_OFC8_n29
zoomSelected
editSelect -net I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n222
zoomSelected
selectInst I0/LD/T_FIFO/IP_FIFO/UFIFORAM/U236
zoomSelected
editSelect -net I0/LD/T_FIFO/IP_FIFO/UFIFORAM/n223
zoomSelected
deselectAll
selectInst FW4
deselectAll
selectInst FW4
deselectAll
selectInst c01
