module top_module (
	input [15:0] in,
	output [7:0] out_hi,
	output [7:0] out_lo
);
	// Splitting the 16-bit input signal into two 8-bit output signals
	assign out_hi = in[15:8];
	assign out_lo = in[7:0];
endmodule
