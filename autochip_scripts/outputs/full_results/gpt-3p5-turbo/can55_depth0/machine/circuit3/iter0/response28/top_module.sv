module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	
  // Logic gate for OR operation on inputs a and b
  wire a_or_b;
  or (a_or_b, a, b);
  
  // Logic gate for OR operation on inputs c and d
  wire c_or_d;
  or (c_or_d, c, d);
  
  // Logic gate for AND operation on outputs of OR gates
  and (q, a_or_b, c_or_d);
  
endmodule
