module top_module(
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    output p1y,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output p2y
);
    wire p1y_inverted;
    wire p2y_inverted;

    assign p1y = ~(&{p1a, p1b, p1c, p1d});
    assign p2y = ~(&{p2a, p2b, p2c, p2d});

    // Inverter for p1y output
    not_gate_1 not1(
        .a(p1y),
        .out(p1y_inverted)
    );

    // Inverter for p2y output
    not_gate_2 not2(
        .a(p2y),
        .out(p2y_inverted)
    );

endmodule
module not_gate_1(
    input a,
    output out
);
    assign out = ~a;

endmodule
module not_gate_2(
    input a,
    output out
);
    assign out = ~a;

endmodule
