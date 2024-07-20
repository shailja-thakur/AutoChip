module top_module (
  input a,
  input b,
  input c,
  input d,
  input e,
  output [24:0] out
);

  wire [24:0] not_a, not_b, not_c, not_d, not_e;
  wire [24:0] a_vector, b_vector;
  
  assign not_a = ~a;
  assign not_b = ~b;
  assign not_c = ~c;
  assign not_d = ~d;
  assign not_e = ~e;
  
  assign a_vector = {25{a}};
  assign b_vector = {25{b}};
  
  assign out = not_a ^ a_vector ^ not_b ^ b_vector ^ not_c ^ c_vector ^ not_d ^ d_vector ^ not_e ^ e_vector;
  
endmodule
