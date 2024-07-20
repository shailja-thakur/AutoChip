module top_module(
    input x,
    input y,
    output z);

    wire a;
    wire b;

    // First gate
    and gate1(a, x, y);

    // Second gate
    or gate2(b, x, y);

    // Third gate
    xor gate3(z, a, b);
    
endmodule
