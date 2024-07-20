module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

  // Sum-of-Products (SOP) minimal form
  assign out_sop = (~a & ~b & c & d) | // 2
                   (a & b & c & ~d)  | // 7
                   (a & b & c & d);   // 15

  // Product-of-Sums (POS) minimal form
  assign out_pos = (a | b | ~c | ~d) &  // For 0, 1
                   (a | ~b | ~c | d)  & // For 4, 5
                   (a | ~b | c | d)   & // For 6
                   (~a | ~b | c | ~d) & // For 9, 10
                   (~a | b | c | d)   & // For 13
                   (a | b | ~c | d);    // For 14

endmodule
