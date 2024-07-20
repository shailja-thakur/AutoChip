module top_module(
    input x,
    input y,
    output z
);

    wire a1, b1, a2, b2, a3, b3;

    // First gate
    and gate1(a1, x, y);

    // Second gate    
    and gate2(b1, y, x);

    // Third gate
    and gate3(a3, a1, b2);
    and gate4(b3, b1, a2);
    or  gate5(z, a3, b3);

endmodule
