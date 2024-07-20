module top_module(
  input a,
  input b,
  output z);

  wire a_in;
  wire b_in;
  wire gate1_out;
  wire gate2_out;
  
  and gate1(a_in, b, gate1_out);
  and gate2(a, b_in, gate2_out);
  and gate3(gate1_out, gate2_out, z);
  
  assign a_in = x;
  assign b_in = y;

endmodule
