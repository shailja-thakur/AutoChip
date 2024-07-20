module top_module(
    input a,
    input b,
    output out
);

    wire or_out;
    or_gate or_inst(
        .a(a),
        .b(b),
        .out(or_out)
    );

    not_gate not_inst(
        .in(or_out),
        .out(out)
    );

endmodule
module or_gate(
    input a,
    input b,
    output out
);
    assign out = a | b;
endmodule
module not_gate(
    input in,
    output out
);
    assign out = ~in;
endmodule
