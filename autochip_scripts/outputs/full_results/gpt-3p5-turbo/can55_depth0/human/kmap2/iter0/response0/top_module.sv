module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3;

and gate1 (w1, ~c, ~d);
and gate2 (w2, c, ~d);
and gate3 (w3, a, b, ~d);

or gate4 (out, w1, w2, w3);

endmodule
module and (output o, input i1, input i2, input i3);
    assign o = i1 & i2 & i3;
endmodule
module or (output o, input i1, input i2, input i3);
    assign o = i1 | i2 | i3;
endmodule
