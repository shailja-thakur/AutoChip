module top_module(
    input x,
    input y,
    output z
);

    // Declare internal signal for XOR operation
    wire xor_output;

    // Declare intermediate signal for negation operation
    wire neg_output;

    // Perform XOR operation
    xor xor_gate(
        .a(x),
        .b(y),
        .z(xor_output)
    );

    // Perform negation operation
    assign z = ~xor_output;

endmodule
module xor(
    input a,
    input b,
    output z
);

    // Declare internal signals
    wire x1, x2, x3;

    // Perform AND and NOT operations for inputs
    and #(2) and_gate1(
        .a(a),
        .b(b),
        .z(x1)
    );

    not not_gate1(
        .a(a),
        .z(x2)
    );

    not not_gate2(
        .a(b),
        .z(x3)
    );

    // Perform OR operation for intermediate signals
    or or_gate(
        .a(x1),
        .b(x2),
        .c(x3),
        .z(z)
    );

endmodule
module and(
    input a,
    input b,
    output z
);

    assign z = a & b;

endmodule
module not(
    input a,
    output z
);

    assign z = ~a;

endmodule
module or(
    input a,
    input b,
    input c,
    output z
);

    wire x1, x2;

    not not_gate1(
        .a(a),
        .z(x1)
    );

    not not_gate2(
        .a(b),
        .z(x2)
    );

    and and_gate(
        .a(x1),
        .b(x2),
        .z(z)
    );

    or or_gate(
        .a(a),
        .b(b),
        .c(c),
        .z(z)
    );

endmodule
