module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

  // Define intermediate signals for the output
  wire out_sop_inter;
  wire out_pos_inter;

  // Determine out_sop in minimum sum-of-products form
  assign out_sop_inter = (a & b & c & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d);
  assign out_sop = out_sop_inter;

  // Determine out_pos in minimum product-of-sums form
  assign out_pos_inter = (a | b | c | ~d) & (~a | ~b | ~c | d) & (~a | ~b | c | ~d);
  assign out_pos = out_pos_inter;

endmodule
