module top_module(
	input x,
	input y,
	output z);
  // Define internal signals
  wire a, b;
  
  // Instantiate gates
  gate1 u1(.a(x), .b(y), .y(a));
  gate2 u2(.a(y), .b(x), .y(b));
  gate3 u3(.a(a), .b(b), .z(z));
  
endmodule
module gate1(
  input a,
  input b,
  output y
);
  assign y = a & b;
endmodule
module gate2(
  input a,
  input b,
  output y
);
  assign y = a | b;
endmodule
module gate3(
  input a,
  input b,
  output z
);
  assign z = a ^ b;
endmodule
