module top_module (
  input a, 
  input b, 
  output q
);
	assign q = a & b;  // Implementing AND gate operation between a and b, and assigning the result to q
endmodule
