module top_module(
	input a, 
	input b,
	output out
);

  // define intermediate wire signals
  wire or_out;
  
  // OR gate
  or_gate or1(a, b, or_out);
  
  // inverter gate
  inverter inv1(or_out, out);
  
endmodule
module or_gate(
  input a,
  input b,
  output y
);

  assign y = a | b;
  
endmodule
module inverter(
  input a,
  output y
);

  assign y = ~a;
  
endmodule
