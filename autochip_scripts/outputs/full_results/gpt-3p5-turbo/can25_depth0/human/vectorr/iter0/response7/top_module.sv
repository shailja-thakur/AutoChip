module top_module (
	input [7:0] in,
	output [7:0] out
);
	
	// Declare a wire for each individual bit of the input vector
	wire in0, in1, in2, in3, in4, in5, in6, in7;

	// Assign each wire to the corresponding bit of the input vector
	assign {in7, in6, in5, in4, in3, in2, in1, in0} = in;

	// Assign each bit of the output vector to the corresponding wire
	assign out = {in0, in1, in2, in3, in4, in5, in6, in7};

endmodule
