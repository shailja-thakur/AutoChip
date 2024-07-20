module top_module(
	input a, 
	input b,
	input c,
	output out
);

  // Define intermediate signals
  wire d, e, f, g;

  // Use the Karnaugh map to define the logic for the signals
  assign d = (!a & !b & !c) | (a & b) | (a & c) | (b & c);
  assign e = (a & !b & !c) | (a & b & !c) | (a & b & c);
  assign f = (!a & b & !c) | (!a & !b & c) | (a & b) | (b & c);
  assign g = (a & b & c) | (!a & c);

  // Define the output using the intermediate signals
  assign out = d | e | f | g;

endmodule
