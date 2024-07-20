module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

	assign sum[0] = x[0] + y[0]; // logic to add least significant bits
	assign sum[1] = x[1] + y[1] + sum[0]; // logic to add second least significant bits and carry
	assign sum[2] = x[2] + y[2] + sum[1]; // logic to add third least significant bits and carry
	assign sum[3] = x[3] + y[3] + sum[2]; // logic to add most significant bits and carry
	assign sum[4] = sum[3]; // assign the carry bit to the most significant bit of the sum

endmodule
