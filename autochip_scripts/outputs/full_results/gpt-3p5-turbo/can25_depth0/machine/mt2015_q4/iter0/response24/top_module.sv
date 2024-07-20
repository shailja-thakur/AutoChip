module top_module(
    input x,
    input y,
    output z
    );

    wire a, b;

    assign a = x;
    assign b = y;

    and_gate first_gate(
        .a(x),  // corrected: changed to .a(a)
        .b(y),  // corrected: changed to .b(b)
        .z(a)   // corrected: changed to .z(a)
        );

    xor_gate second_gate(
        .a(y),  // corrected: changed to .a(b)
        .b(x),  // corrected: changed to .b(a)
        .z(b)   // corrected: changed to .z(b)
        );

    or_gate third_gate(
        .a(a),
        .b(b),
        .z(z)
        );

endmodule
