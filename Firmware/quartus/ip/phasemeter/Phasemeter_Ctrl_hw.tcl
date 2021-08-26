# TCL File Generated by Component Editor 21.1
# Tue May 25 15:07:24 CEST 2021
# DO NOT MODIFY


# 
# Phasemeter_Ctrl "Phasemeter_Ctrl" v1.0
# Herve Echelard 2021.05.25.15:07:24
# 
# 

# 
# request TCL package from ACDS 21.1
# 
package require -exact qsys 21.1


# 
# module Phasemeter_Ctrl
# 
set_module_property DESCRIPTION ""
set_module_property NAME Phasemeter_Ctrl
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Orolia
set_module_property AUTHOR "Herve Echelard"
set_module_property DISPLAY_NAME Phasemeter_Ctrl
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false
set_module_property LOAD_ELABORATION_LIMIT 0


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL phasemeter
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file phasemeter.vhd VHDL PATH phasemeter.vhd TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock_phase
# 
add_interface clock_phase clock end
set_interface_property clock_phase ENABLED true
set_interface_property clock_phase EXPORT_OF ""
set_interface_property clock_phase PORT_NAME_MAP ""
set_interface_property clock_phase CMSIS_SVD_VARIABLES ""
set_interface_property clock_phase SVD_ADDRESS_GROUP ""
set_interface_property clock_phase IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port clock_phase CLK200_I clk Input 1


# 
# connection point reset_phase
# 
add_interface reset_phase reset end
set_interface_property reset_phase associatedClock clock_phase
set_interface_property reset_phase synchronousEdges DEASSERT
set_interface_property reset_phase ENABLED true
set_interface_property reset_phase EXPORT_OF ""
set_interface_property reset_phase PORT_NAME_MAP ""
set_interface_property reset_phase CMSIS_SVD_VARIABLES ""
set_interface_property reset_phase SVD_ADDRESS_GROUP ""
set_interface_property reset_phase IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port reset_phase RST200_I reset Input 1


# 
# connection point clock_avalon
# 
add_interface clock_avalon clock end
set_interface_property clock_avalon ENABLED true
set_interface_property clock_avalon EXPORT_OF ""
set_interface_property clock_avalon PORT_NAME_MAP ""
set_interface_property clock_avalon CMSIS_SVD_VARIABLES ""
set_interface_property clock_avalon SVD_ADDRESS_GROUP ""
set_interface_property clock_avalon IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port clock_avalon CLK_CPU_I clk Input 1


# 
# connection point reset_avalon
# 
add_interface reset_avalon reset end
set_interface_property reset_avalon associatedClock clock_avalon
set_interface_property reset_avalon synchronousEdges DEASSERT
set_interface_property reset_avalon ENABLED true
set_interface_property reset_avalon EXPORT_OF ""
set_interface_property reset_avalon PORT_NAME_MAP ""
set_interface_property reset_avalon CMSIS_SVD_VARIABLES ""
set_interface_property reset_avalon SVD_ADDRESS_GROUP ""
set_interface_property reset_avalon IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port reset_avalon RST_CPU_I reset Input 1


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressGroup 0
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_avalon
set_interface_property avalon_slave associatedReset reset_avalon
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave bridgedAddressOffset ""
set_interface_property avalon_slave bridgesToMaster ""
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave maximumPendingWriteTransactions 0
set_interface_property avalon_slave minimumResponseLatency 1
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave transparentBridge false
set_interface_property avalon_slave waitrequestAllowance 0
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""
set_interface_property avalon_slave IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port avalon_slave ADR_I address Input 4
add_interface_port avalon_slave RD_I read Input 1
add_interface_port avalon_slave WE_I write Input 1
add_interface_port avalon_slave DAT_I writedata Input 32
add_interface_port avalon_slave DAT_O readdata Output 32
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point PPS_GNSS
# 
add_interface PPS_GNSS conduit end
set_interface_property PPS_GNSS associatedClock clock_phase
set_interface_property PPS_GNSS associatedReset reset_phase
set_interface_property PPS_GNSS ENABLED true
set_interface_property PPS_GNSS EXPORT_OF ""
set_interface_property PPS_GNSS PORT_NAME_MAP ""
set_interface_property PPS_GNSS CMSIS_SVD_VARIABLES ""
set_interface_property PPS_GNSS SVD_ADDRESS_GROUP ""
set_interface_property PPS_GNSS IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port PPS_GNSS PPS_GNSS pps_gnss Input 1


# 
# connection point irq1
# 
add_interface irq1 interrupt end
set_interface_property irq1 associatedClock clock_avalon
set_interface_property irq1 associatedReset reset_avalon
set_interface_property irq1 bridgedReceiverOffset ""
set_interface_property irq1 bridgesToReceiver ""
set_interface_property irq1 ENABLED true
set_interface_property irq1 EXPORT_OF ""
set_interface_property irq1 PORT_NAME_MAP ""
set_interface_property irq1 CMSIS_SVD_VARIABLES ""
set_interface_property irq1 SVD_ADDRESS_GROUP ""
set_interface_property irq1 IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port irq1 IRQ1_O irq Output 1


# 
# connection point PPS_REF
# 
add_interface PPS_REF conduit end
set_interface_property PPS_REF associatedClock clock_phase
set_interface_property PPS_REF associatedReset reset_phase
set_interface_property PPS_REF ENABLED true
set_interface_property PPS_REF EXPORT_OF ""
set_interface_property PPS_REF PORT_NAME_MAP ""
set_interface_property PPS_REF CMSIS_SVD_VARIABLES ""
set_interface_property PPS_REF SVD_ADDRESS_GROUP ""
set_interface_property PPS_REF IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port PPS_REF PPS_I pps_i Input 1


# 
# connection point ext_offset
# 
add_interface ext_offset conduit end
set_interface_property ext_offset associatedClock clock_phase
set_interface_property ext_offset associatedReset reset_phase
set_interface_property ext_offset ENABLED true
set_interface_property ext_offset EXPORT_OF ""
set_interface_property ext_offset PORT_NAME_MAP ""
set_interface_property ext_offset CMSIS_SVD_VARIABLES ""
set_interface_property ext_offset SVD_ADDRESS_GROUP ""
set_interface_property ext_offset IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port ext_offset OFFSET_PHASE_O offset_phase Output 32
add_interface_port ext_offset REQUEST_OFFSET_O request_offset Output 1
add_interface_port ext_offset ACK_OFFSET_I ack_offset Input 1


# 
# connection point PHASE_DEBUG
# 
add_interface PHASE_DEBUG conduit end
set_interface_property PHASE_DEBUG associatedClock ""
set_interface_property PHASE_DEBUG associatedReset ""
set_interface_property PHASE_DEBUG ENABLED true
set_interface_property PHASE_DEBUG EXPORT_OF ""
set_interface_property PHASE_DEBUG PORT_NAME_MAP ""
set_interface_property PHASE_DEBUG CMSIS_SVD_VARIABLES ""
set_interface_property PHASE_DEBUG SVD_ADDRESS_GROUP ""
set_interface_property PHASE_DEBUG IPXACT_REGISTER_MAP_VARIABLES ""

add_interface_port PHASE_DEBUG PHASE_DEBUG phase_debug Output 32

