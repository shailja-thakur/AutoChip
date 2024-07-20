module top_module(
	input x,
	input y,
	output z);

  // declare internal wires
  wire t1, t2, t3;

  // xor gate
  xor_gate xor1(
    .a(x),
    .b(y),
    .z(t1)
  );

  // not gate
  not_gate not1(
    .a(t1),
    .z(t2)
  );

  // or gate
  or_gate or1(
    .a(x),
    .b(y),
    .z(t3)
  );

  // and gate
  and_gate and1(
    .a(t3),
    .b(t2),
    .z(z)
  );

endmodule
