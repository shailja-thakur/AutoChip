module top_module(
	input x,
	input y,
	output z);

  // Declare internal signals
  wire a1, b1, a2, b2, a3, b3;
  
  // Instantiate gates
  not_gate not1(.a(x), .z(a1));
  not_gate not2(.a(y), .z(b1));
  and_gate and1(.a(x), .b(y), .z(a2));
  and_gate and2(.a(y), .b(x), .z(b2));
  and_gate and3(.a(a1), .b(b1), .z(a3));
  and_gate and4(.a(a2), .b(b2), .z(b3));
  or_gate or1(.a(a3), .b(b3), .z(z));

endmodule
module not_gate(
  input a,
  output z);
  
  assign z = ~a;

endmodule
module and_gate(
  input a,
  input b,
  output z);
  
  assign z = a & b;

endmodule
module or_gate(
  input a,
  input b,
  output z);
  
  assign z = a | b;

endmodule
