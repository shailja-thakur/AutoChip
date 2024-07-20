module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    and u1 (out1, x, y);      // First gate
    or  u2 (out2, y, x);      // Second gate
    xor u3 (z, out1, out2);   // Third gate

endmodule
