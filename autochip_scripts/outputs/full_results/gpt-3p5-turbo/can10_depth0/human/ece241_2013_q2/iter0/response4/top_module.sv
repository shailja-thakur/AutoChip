module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
  
  // SOP method
  wire term1 = a & a & ~b & ~c & ~d; // term that corresponds to input 2
  wire term2 = a & ~b & ~c & ~d; // term that corresponds to input 7
  wire term3 = a & ~b & ~c & ~d; // term that corresponds to input 15
  
  assign out_sop = term1 | term2 | term3; // output in sum-of-products form
  
  // POS method
  wire sum1 = a | a | b | c | d; // sum that corresponds to input 0
  wire sum2 = a | b | c | d; // sum that corresponds to input 1
  wire sum3 = a | b | c | d; // sum that corresponds to input 4
  wire sum4 = a | b | c | d; // sum that corresponds to input 5
  wire sum5 = a | b | c | d; // sum that corresponds to input 6
  wire sum6 = a | b | c | d; // sum that corresponds to input 9
  wire sum7 = a | b | c | d; // sum that corresponds to input 10
  wire sum8 = a | b | c | d; // sum that corresponds to input 13
  wire sum9 = a | b | c | d; // sum that corresponds to input 14
  
  assign out_pos = sum1 & sum2 & sum3 & sum4 & sum5 & sum6 & sum7 & sum8 & sum9; // output in product-of-sums form

endmodule
