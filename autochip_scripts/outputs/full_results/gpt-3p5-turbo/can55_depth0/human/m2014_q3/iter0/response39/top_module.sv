module top_module (
	input [4:1] x,
	output logic f
);

assign f = (x == 4'b0100) ? 1'b1 :
           (x == 4'b0101) ? 1'b0 :
           (x == 4'b0110) ? 1'b1 :
           (x == 4'b0111) ? 1'b1 :
           (x == 4'b1100) ? 1'b1 :
           (x == 4'b1110) ? 1'b1 :
           (x == 4'b1111) ? 1'b0 :
           1'b0;

endmodule
