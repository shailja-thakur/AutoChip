module top_module(
    input x,
    input y,
    output z
);

    // Wire declaration
    wire w1;

    // XOR gate
    xor gate1(
        .a(x),
        .b(y),
        .o(w1)
    );

    // AND gate
    and gate2(
        .a(w1),
        .b(x),
        .o(z)
    );

endmodule
module xor(
    input a,
    input b,
    output o
);
    assign o = a ^ b;
endmodule
module and(
    input a,
    input b,
    output o
);
    assign o = a & b;
endmodule
