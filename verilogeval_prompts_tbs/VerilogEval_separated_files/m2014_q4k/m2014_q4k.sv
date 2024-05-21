// Implement a shift register with four D flops. Reset is active-low synchronous resettable.

module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
