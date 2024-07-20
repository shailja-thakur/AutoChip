module top_module(
    input in,
    output out
);

    notGate not1(
        .in(in),
        .out(out)
    );

endmodule
module notGate(
    input in,
    output out
);

    assign out = ~in;

endmodule
