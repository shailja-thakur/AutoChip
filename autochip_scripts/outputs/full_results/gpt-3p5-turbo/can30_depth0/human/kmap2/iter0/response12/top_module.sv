module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3, w4, w5, w6, w7, w8;

and_gate and1 (w1, ~a, ~b, ~c, d);
and_gate and2 (w2, ~a, ~b, c, ~d);
and_gate and3 (w3, ~a, b, ~c, ~d);
and_gate and4 (w4, ~a, ~b, c, d);
and_gate and5 (w5, a, ~b, ~c, ~d);
and_gate and6 (w6, a, ~b, c, ~d);
and_gate and7 (w7, a, b, c, ~d);
and_gate and8 (w8, a, b, ~c, d);

or_gate or1 (out, w1, w2, w3, w4, w5, w6, w7, w8);

endmodule
