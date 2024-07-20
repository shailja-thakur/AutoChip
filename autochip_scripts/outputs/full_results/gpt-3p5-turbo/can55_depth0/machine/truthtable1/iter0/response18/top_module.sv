module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

  wire not_x3;
  wire not_x2;
  wire not_x1;

  assign not_x3 = ~x3;
  assign not_x2 = ~x2;
  assign not_x1 = ~x1;

  assign f = (not_x3 & x2 & not_x1) | (not_x3 & x2 & x1) | (x3 & not_x2 & x1) | (x3 & x2 & x1);

endmodule
