module top_module(
	input x,
	input y,
	output z);

  wire a, b;
   
  andGate #(1) and1 (.a(x), .b(y), .z(a));
  andGate #(1) and2 (.a(y), .b(x), .z(b));
  andGate #(1) and3 (.a(a), .b(b), .z(z));
  
endmodule
module andGate(
  input a,
  input b,
  output z);

  assign z = a & b;
  
endmodule
