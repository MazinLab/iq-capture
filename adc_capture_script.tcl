open_project adc-capture
set_top adc_capture
add_files src/capture.cpp
add_files src/capture.hpp
add_files -tb src/tb.cpp -cflags "-Wno-unknown-pragmas"
open_solution "solution1"
set_part {xczu28dr-ffvg1517-2-e}
create_clock -period 550MHz -name default
config_export -description {Select and tag the ADC stream from gen3 for capture} -display_name "ADC Capture" -format ip_catalog -library mkidgen3 -rtl verilog -vendor MazinLab -version 0.1
csim_design
csynth_design
#cosim_design -tool xsim

