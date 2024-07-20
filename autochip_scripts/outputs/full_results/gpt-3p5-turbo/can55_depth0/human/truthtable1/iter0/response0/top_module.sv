module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

  // Define the combinational logic equations for the output f
  assign f = (x2 && !x1) || (!x3 && x2) || (x1 && x3);

endmodule
