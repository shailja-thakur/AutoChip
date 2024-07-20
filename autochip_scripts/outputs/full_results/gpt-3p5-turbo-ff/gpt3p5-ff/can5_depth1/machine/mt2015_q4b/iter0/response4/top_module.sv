module top_module(
    input x,
    input y,
    output z
    );

    wire temp;
    wire a;
    wire b;

    xor_gate u1(
        .a(x),
        .b(y),
        .z(temp)
    );

    not_gate u2(
        .a(temp),
        .z(z)
    );

endmodule
module xor_gate(
    input a,
    input b,
    output z
    );

    assign z = a ^ b;

endmodule
module not_gate(
    input a,
    output z
    );

    assign z = ~a;

endmodule
