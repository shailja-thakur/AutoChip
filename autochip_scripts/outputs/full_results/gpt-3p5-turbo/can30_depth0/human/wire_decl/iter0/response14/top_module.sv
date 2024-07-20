module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n
);
  
  wire intermediate_wire_1;
  wire intermediate_wire_2;
  
  and U1(intermediate_wire_1, a, b);
  and U2(intermediate_wire_2, c, d);
  or U3(out, intermediate_wire_1, intermediate_wire_2);
  not U4(out_n, out);

endmodule
