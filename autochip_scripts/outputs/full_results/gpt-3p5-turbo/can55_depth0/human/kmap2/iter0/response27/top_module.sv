module top_module (
   input a, 
   input b,
   input c,
   input d,
   output out
);
   wire w1, w2, w3, w4, w5, w6;

   and #(4) and_gate1 (w1, a, b, !c, d);
   and #(4) and_gate2 (w2, a, b, c, d);
   and #(4) and_gate3 (w3, a, !b, c, d);
   and #(4) and_gate4 (w4, !a, b, c, d);
   or #(4) or_gate (w5, w1, w2, w3, w4);
   buf buf_gate (out, w5);
endmodule
