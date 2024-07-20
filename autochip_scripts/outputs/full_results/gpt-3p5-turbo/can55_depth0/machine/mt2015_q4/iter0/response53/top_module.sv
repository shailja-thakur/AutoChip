module top_module(
	input x,
	input y,
	output z
);

  // Internal signals
  wire a1, b1, a2, b2;

  // First gate
  and gate1(a1, x, y);
  not not_gate1(b1, x);

  // Second gate
  and gate2(a2, y, x);
  not not_gate2(b2, y);

  // Third gate
  or gate3(z, a1, b2);

endmodule
