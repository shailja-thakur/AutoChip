module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Define a 4-bit wide multiplexer
	wire [3:0] mux_out;
	mux4to1 mux (
		.in0(in[sel * 64 +: 4]),
		.in1(in[sel * 64 + 4 +: 4]),
		.in2(in[sel * 64 + 8 +: 4]),
		.in3(in[sel * 64 + 12 +: 4]),
		.sel(0),
		.out(mux_out)
	);
	
	// Output the selected 4-bit value
	assign out = mux_out;
	
	// Define a 4-to-1 multiplexer for selecting the output
	mux4to1 sel_mux (
		.in0(out[0]),
		.in1(out[1]),
		.in2(out[2]),
		.in3(out[3]),
		.sel(sel[2:0]),
		.out(out)
	);
	
endmodule
module mux4to1 (
	input [3:0] in0,
	input [3:0] in1,
	input [3:0] in2,
	input [3:0] in3,
	input [1:0] sel,
	output reg [3:0] out
);
	always @(*)
		case(sel)
			2'b00: out = in0;
			2'b01: out = in1;
			2'b10: out = in2;
			2'b11: out = in3;
		endcase
endmodule
