# 
# Synthesis run script generated by Vivado
# 

  set_param gui.test TreeTableDev
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z020clg484-1
set_property target_language VHDL [current_project]
set_property board_part em.avnet.com:zed:part0:1.0 [current_project]
set_param project.compositeFile.enableAutoGeneration 0
set_property default_lib xil_defaultlib [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.srcs/sources_1/new/RxFSM.vhd
  C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.srcs/sources_1/new/ClockGenerator.vhd
  C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.srcs/sources_1/new/RxSystem.vhd
  C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.srcs/sources_1/new/BluetoothConnector.vhd
}
read_xdc C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.srcs/constrs_1/new/BluetoothController_constraints.xdc
set_property used_in_implementation false [get_files C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.srcs/constrs_1/new/BluetoothController_constraints.xdc]

set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Gabriel/projets/cpsn/BluetoothConnector/BluetoothConnector.cache/wt [current_project]
set_property parent.project_dir C:/Users/Gabriel/projets/cpsn/BluetoothConnector [current_project]
catch { write_hwdef -file BluetoothConnector.hwdef }
synth_design -top BluetoothConnector -part xc7z020clg484-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off
write_checkpoint BluetoothConnector.dcp
report_utilization -file BluetoothConnector_utilization_synth.rpt -pb BluetoothConnector_utilization_synth.pb