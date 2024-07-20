//  This Verilog module is a simple combinational logic circuit. It has three ports: an input port 'd', an enable port 'ena', and an output port 'q'. The enable port is used to control the output port. When the enable port is active (high), the output port will be equal to the value of the input port. When the enable port is inactive (low), the output port will remain unchanged. This module is useful for controlling the flow of data in a circuit, as it allows the user to enable or disable the flow of data from the input port to the output port.

module top_module (
	input d,
	input ena,
	output logic q
);
