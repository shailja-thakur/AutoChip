module top_module(
    input x,
    input y,
    output z);

    // First gate
    wire a1;
    and gate1(a1, x, y);
    
    // Second gate
    wire b1;
    and gate2(b1, y, x);
    
    // Third gate
    wire z;
    or gate3(z, a1, b1);

endmodule
