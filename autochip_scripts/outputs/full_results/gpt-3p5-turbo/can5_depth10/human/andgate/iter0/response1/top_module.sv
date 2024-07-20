module top_module(
  input a, 
  input b,
  output out
);
	assign out = a & b;    // Using bitwise AND operator to implement an AND gate
endmodule
