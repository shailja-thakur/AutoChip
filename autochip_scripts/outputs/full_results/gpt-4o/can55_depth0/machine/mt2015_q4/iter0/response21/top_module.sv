module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

    // First gate instance
    and gate1(
        .a(x),
        .b(y),
        .z(out1)
    );

    // Second gate instance
    or gate2(
        .a(y),
        .b(x),
        .z(out2)
    );

    // Third gate instance
    xor gate3(
        .a(out1),
        .b(out2),
        .z(z)
    );

endmodule
