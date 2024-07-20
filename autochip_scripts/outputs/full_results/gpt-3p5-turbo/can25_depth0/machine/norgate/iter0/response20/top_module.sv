module top_module(
    input a,
    input b,
    output out
);

    wire or_result;

    // OR gate
    or_gate or1(
        .a(a),
        .b(b),
        .out(or_result)
    );

    // Inverter
    inverter inv1(
        .in(or_result),
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
module inverter(
    input in,
    output out
);

    assign out = ~in;

endmodule
