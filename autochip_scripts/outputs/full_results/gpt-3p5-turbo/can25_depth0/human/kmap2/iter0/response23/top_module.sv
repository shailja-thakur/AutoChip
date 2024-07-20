module top_module (
  input a, 
  input b,
  input c,
  input d,
  output out
);

  wire not_a;
  wire not_b;
  wire not_c;
  wire not_d;

  wire and_gate1;
  wire and_gate2;
  wire and_gate3;
  wire and_gate4;

  wire or_gate1;
  wire or_gate2;
  wire or_gate3;
  wire or_gate4;

  assign not_a = ~a;
  assign not_b = ~b;
  assign not_c = ~c;
  assign not_d = ~d;

  assign and_gate1 = not_a & not_b & not_c & d;
  assign and_gate2 = not_a & c & not_b & d;
  assign and_gate3 = not_a & b & not_c & d;
  assign and_gate4 = a & not_b & not_c & not_d;

  assign or_gate1 = and_gate1 | and_gate2 | and_gate3 | and_gate4;
  assign out = or_gate1;

endmodule
