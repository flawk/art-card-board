# TCL File Generated by Component Editor 13.1
# Tue Apr 29 11:37:48 MDT 2014
# DO NOT MODIFY


# 
# OpenCore_16550_uart "OpenCore 16550 uart" v13.1
#  2014.04.29.11:37:48
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module OpenCore_16550_uart
# 
set_module_property DESCRIPTION ""
set_module_property NAME OpenCore_16550_uart
set_module_property VERSION 13.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Interface Protocols/Serial"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "OpenCore 16550 uart"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL avalon_uart_top
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file avalon_uart_top.v VERILOG PATH avalon_uart_top.v TOP_LEVEL_FILE
add_fileset_file raminfr.v VERILOG PATH raminfr.v
add_fileset_file timescale.v VERILOG PATH timescale.v
add_fileset_file uart_debug_if.v VERILOG PATH uart_debug_if.v
add_fileset_file uart_defines.v VERILOG PATH uart_defines.v
add_fileset_file uart_receiver.v VERILOG PATH uart_receiver.v
add_fileset_file uart_regs.v VERILOG PATH uart_regs.v
add_fileset_file uart_rfifo.v VERILOG PATH uart_rfifo.v
add_fileset_file uart_top.v VERILOG PATH uart_top.v
add_fileset_file uart_transmitter.v VERILOG PATH uart_transmitter.v
add_fileset_file uart_wb.v VERILOG PATH uart_wb.v
add_fileset_file uart_tfifo.v VERILOG PATH uart_tfifo.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink avc_c1_clk clk Input 1


# 
# connection point clock_sink_reset
# 
add_interface clock_sink_reset reset end
set_interface_property clock_sink_reset associatedClock clock_sink
set_interface_property clock_sink_reset synchronousEdges DEASSERT
set_interface_property clock_sink_reset ENABLED true
set_interface_property clock_sink_reset EXPORT_OF ""
set_interface_property clock_sink_reset PORT_NAME_MAP ""
set_interface_property clock_sink_reset CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink_reset SVD_ADDRESS_GROUP ""

add_interface_port clock_sink_reset avc_c1_reset reset Input 1


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint s1
set_interface_property interrupt_sender associatedClock clock_sink
set_interface_property interrupt_sender associatedReset clock_sink_reset
set_interface_property interrupt_sender bridgedReceiverOffset ""
set_interface_property interrupt_sender bridgesToReceiver ""
set_interface_property interrupt_sender ENABLED true
set_interface_property interrupt_sender EXPORT_OF ""
set_interface_property interrupt_sender PORT_NAME_MAP ""
set_interface_property interrupt_sender CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender avi_int_irq irq Output 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end stx_pad_o export Output 1
add_interface_port conduit_end srx_pad_i export Input 1
add_interface_port conduit_end rts_pad_o export Output 1
add_interface_port conduit_end cts_pad_i export Input 1
add_interface_port conduit_end dtr_pad_o export Output 1
add_interface_port conduit_end dsr_pad_i export Input 1
add_interface_port conduit_end ri_pad_i export Input 1
add_interface_port conduit_end dcd_pad_i export Input 1


# 
# connection point s1
# 
add_interface s1 avalon end
set_interface_property s1 addressAlignment NATIVE
set_interface_property s1 addressUnits WORDS
set_interface_property s1 associatedClock clock_sink
set_interface_property s1 associatedReset clock_sink_reset
set_interface_property s1 bitsPerSymbol 8
set_interface_property s1 burstOnBurstBoundariesOnly false
set_interface_property s1 burstcountUnits WORDS
set_interface_property s1 explicitAddressSpan 0
set_interface_property s1 holdTime 0
set_interface_property s1 linewrapBursts false
set_interface_property s1 maximumPendingReadTransactions 0
set_interface_property s1 readLatency 0
set_interface_property s1 readWaitTime 1
set_interface_property s1 setupTime 0
set_interface_property s1 timingUnits Cycles
set_interface_property s1 writeWaitTime 0
set_interface_property s1 ENABLED true
set_interface_property s1 EXPORT_OF ""
set_interface_property s1 PORT_NAME_MAP ""
set_interface_property s1 CMSIS_SVD_VARIABLES ""
set_interface_property s1 SVD_ADDRESS_GROUP ""

add_interface_port s1 avs_s1_address address Input 3
add_interface_port s1 avs_s1_writedata writedata Input 32
add_interface_port s1 avs_s1_read read Input 1
add_interface_port s1 avs_s1_chipselect chipselect Input 1
add_interface_port s1 avs_s1_readdata readdata Output 32
add_interface_port s1 avs_s1_write write Input 1
add_interface_port s1 avs_s1_waitrequest_n waitrequest_n Output 1
set_interface_assignment s1 embeddedsw.configuration.isFlash 0
set_interface_assignment s1 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s1 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s1 embeddedsw.configuration.isPrintableDevice 0
