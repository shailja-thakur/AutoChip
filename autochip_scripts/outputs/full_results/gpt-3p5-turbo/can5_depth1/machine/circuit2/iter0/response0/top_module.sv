module top_module (input a, input b, input c, input d, output q);
  xor #(4) xor_inst (.a({a, b, c, d}), .z(q));
  assign q = ~q;
endmodule
