module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);
 
wire w1, w2, w3;
 
and and_gate1(w1, a, c);
and and_gate2(w2, b, d);
or or_gate(out, w1, w2, c, d);
 
endmodule
