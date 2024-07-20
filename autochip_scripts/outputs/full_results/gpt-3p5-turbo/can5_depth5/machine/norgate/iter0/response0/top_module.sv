module top_module(
    input a,
    input b,
    output out
);

    // OR gate
    or_gate or(
        .a(a),
        .b(b),
        .out(temp_out)
    );

    // Inverter
    inverter inv(
        .in(temp_out),
        .out(out)
    );

endmodule
module or_gate(
    input a,
    input b,
    output out
);

    // Gate level implementation of an OR gate
    assign out = a | b;

endmodule
module inverter(
    input in,
    output out
);

    // Gate level implementation of an inverter
    assign out = ~in;

endmodule
