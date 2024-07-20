module top_module (
	input clk,
	input in,
	output logic out
);

reg d;

// Implementing the XOR gate
assign out = in ^ d;

// Implementing the D flip-flop
always @(posedge clk)
	d <= out;

endmodule
