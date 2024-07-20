module top_module(
	input x,
	input y,
	output z);

  // Define internal signals
  wire a_intermediate, b_intermediate;

  // Instantiate first gate
  gate_1 gate1(.a(x), .b(y), .z(a_intermediate));

  // Instantiate second gate
  gate_2 gate2(.a(y), .b(x), .z(b_intermediate));

  // Instantiate third gate
  gate_3 gate3(.a(a_intermediate), .b(b_intermediate), .z(z));

endmodule
