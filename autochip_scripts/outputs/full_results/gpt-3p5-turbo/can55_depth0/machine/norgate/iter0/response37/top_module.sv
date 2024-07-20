module top_module(
    input a,
    input b,
    output out
);

    wire or_output;
    or_gate or_inst(.a(a), .b(b), .out(or_output));
    inv_gate inv_inst(.in(or_output), .out(out));

endmodule
module or_gate(
    input a,
    input b,
    output out
);

    assign out = a | b;

endmodule
module inv_gate(
    input in,
    output out
);

    assign out = ~in;

endmodule
