module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate, let's assume it's an AND gate
    and u1 (out1, x, y);

    // Second gate, let's assume it's an OR gate
    or u2 (out2, y, x);

    // Third gate, let's assume it's a XOR gate
    xor u3 (z, out1, out2);

endmodule
