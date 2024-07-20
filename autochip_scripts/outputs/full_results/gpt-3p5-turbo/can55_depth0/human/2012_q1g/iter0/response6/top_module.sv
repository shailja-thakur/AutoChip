module top_module (
	input [4:1] x,
	output logic f
);

  // Define the truth table for f
  //  00 | 1
  //  01 | 0
  //  11 | 1
  //  10 | 1
  assign f = (x[3:2] == 2'b11) || (x[3:2] == 2'b10);

endmodule
