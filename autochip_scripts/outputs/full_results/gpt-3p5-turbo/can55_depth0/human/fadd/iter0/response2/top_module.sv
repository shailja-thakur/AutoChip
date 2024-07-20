module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

  // intermediate wire declarations
  wire w1, w2, w3;

  // AND gate declaration
  and_gate and1 (
    .a(a),
    .b(b),
    .z(w1)
  );

  and_gate and2 (
    .a(b),
    .b(cin),
    .z(w2)
  );

  and_gate and3 (
    .a(a),
    .b(cin),
    .z(w3)
  );

  // XOR gate declaration
  xor_gate xor1 (
    .a(a),
    .b(b),
    .z(sum)
  );

  xor_gate xor2 (
    .a(sum),
    .b(cin),
    .z(cout)
  );

  // OR gate declaration
  or_gate or1 (
    .a(w1),
    .b(w2),
    .c(w3),
    .z(cout)
  ); 

endmodule
