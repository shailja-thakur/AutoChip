module top_module(
    input a, 
    input b,
    output out
);

wire or_output;

or_gate or1(a, b, or_output);
not_gate not1(or_output, out);

endmodule
module or_gate(
    input a,
    input b,
    output out
);

assign out = a | b;

endmodule
module not_gate(
    input a,
    output out
);

assign out = ~a;

endmodule
