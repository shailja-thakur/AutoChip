module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3;

and gate1 (w1, a, b);
and gate2 (w2, c, d);
and gate3 (w3, b, c);
and gate4 (out, a, w2);
or gate5 (out, out, w1);
or gate6 (out, out, w3);

endmodule
module and (
    output out,
    input a,
    input b
);
assign out = a & b;
endmodule
module or (
    output out,
    input a,
    input b
);
assign out = a | b;
endmodule
