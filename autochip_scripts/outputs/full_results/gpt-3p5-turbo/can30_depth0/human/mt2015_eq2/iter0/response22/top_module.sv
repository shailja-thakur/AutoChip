module top_module(
	input [1:0] A,
	input [1:0] B,
	output z);

  // wire declaration for intermediate signals
  wire [1:0] difference;

  // assign the difference between A and B to the difference wire
  assign difference = A ^ B;

  // logic to check if difference is zero and assign the appropriate value to z
  assign z = (difference == 0) ? 1'b1 : 1'b0;

endmodule
