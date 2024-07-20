module top_module (
	input [4:1] x,
	output logic f
);

  assign f = (x == 4'h2) || (x == 4'h4) || (x == 4'h6) || (x == 4'h11) || (x == 4'h12) || (x == 4'h13) || (x == 4'h15);

endmodule
