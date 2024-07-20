module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Wire declarations
	wire in0, in1, in2, in3;
	wire out_both0, out_both1, out_both2;
	wire out_any0, out_any1, out_any2, out_any3;
	wire out_different0, out_different1, out_different2, out_different3;
	
	// Splitting input wires
	assign {in0, in1, in2, in3} = in;
	
	// Logic for out_both
	assign out_both0 = in3 & in2;
	assign out_both1 = in0 & in3;
	assign out_both2 = in1 & in0;
	
	// Logic for out_any
	assign out_any0 = in1 | in2;
	assign out_any1 = in2 | in3;
	assign out_any2 = in3 | in0;
	assign out_any3 = in0 | in1;
	
	// Logic for out_different
	assign out_different0 = in3 ^ in2;
	assign out_different1 = in0 ^ in3;
	assign out_different2 = in1 ^ in0;
	assign out_different3 = in2 ^ in1;
	
	// Assigning output
	assign out_both = {out_both2, out_both1, out_both0};
	assign out_any = {out_any3, out_any2, out_any1, out_any0};
	assign out_different = {out_different3, out_different2, out_different1, out_different0};

endmodule
