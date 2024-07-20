module xnor_gate(
    input a,
    input b,
    output out
);

    assign out = ~(a ^ b);

endmodule
module top_module(
    input a,
    input b,
    output out
);

    xnor_gate xnor_gate1(
        .a(a),
        .b(b),
        .out(out)
    );

endmodule
