module top_module(
    input x,
    input y,
    output z);

    wire a, b;  // intermediate wires
    
    // First gate
    and gate1(
        .a(x),
        .b(y),
        .z(a)
    );

    // Second gate
    and gate2(
        .a(y),
        .b(x),
        .z(b)
    );

    // Third gate
    or gate3(
        .a(a),
        .b(b),
        .z(z)
    );

endmodule
