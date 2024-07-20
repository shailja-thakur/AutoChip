module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

  // Implement the truth table from the Karnaugh map
  assign out = (c & d & !a) | (c & !d & !b) | (!c & d & !b) | (a & b & c & !d) | (a & b & d);
  
endmodule
