module top_module (
	input [7:0] in,
	output [7:0] out
);
	
	// Define a wire for each bit in the input vector
	wire b0, b1, b2, b3, b4, b5, b6, b7;

	// Assign each wire to the corresponding bit in the input vector
	assign b0 = in[0];
	assign b1 = in[1];
	assign b2 = in[2];
	assign b3 = in[3];
	assign b4 = in[4];
	assign b5 = in[5];
	assign b6 = in[6];
	assign b7 = in[7];

	// Reverse the bit ordering by assigning the reversed wires to the output vector
	assign out[0] = b7;
	assign out[1] = b6;
	assign out[2] = b5;
	assign out[3] = b4;
	assign out[4] = b3;
	assign out[5] = b2;
	assign out[6] = b1;
	assign out[7] = b0;

endmodule
