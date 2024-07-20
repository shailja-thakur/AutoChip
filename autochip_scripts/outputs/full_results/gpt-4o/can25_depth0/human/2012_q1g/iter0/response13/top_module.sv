module top_module (
	input [4:1] x,
	output logic f
);

	assign f = (x == 4'b0000) || (x == 4'b0011) || (x == 4'b0110) || (x == 4'b0111) ||
	           (x == 4'b1000) || (x == 4'b1001) || (x == 4'b1011) || (x == 4'b1110) || (x == 4'b1111);

endmodule
