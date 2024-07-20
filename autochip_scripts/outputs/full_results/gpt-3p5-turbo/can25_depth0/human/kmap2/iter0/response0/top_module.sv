module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

  // Create the truth table using the Karnaugh map values
  wire w1, w2, w3;

  assign w1 = (a & ~b & c & d) | (~a & b & ~c & d) | (a & b & ~c & ~d);
  assign w2 = (a & ~b & ~c & d) | (~a & ~b & ~c & d) | (~a & b & c & d) | (a & ~b & c & d);
  assign w3 = (a & ~b & c & ~d) | (~a & ~b & c & ~d) | (a & b & c & d);

  // OR all the intermediate signals to get the final output
  assign out = w1 | w2 | w3;

endmodule
