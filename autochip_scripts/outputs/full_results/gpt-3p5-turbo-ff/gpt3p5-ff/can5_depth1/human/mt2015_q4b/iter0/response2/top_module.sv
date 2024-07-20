module top_module(
	input x,
	input y,
	output z);

  // Declare internal signals
  wire a;
  wire b;

  // Assign internal signals
  assign a = !(x & y);
  assign b = !(x | y);

  // Assign output
  assign z = a | b;

endmodule
