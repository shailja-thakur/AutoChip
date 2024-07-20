module top_module(
    input x,
    input y,
    output z);

    wire out1, out2;

    // First gate logic (AND gate as an example)
    and u1 (out1, x, y);

    // Second gate logic (OR gate as an example)
    or u2 (out2, y, x);

    // Third gate logic (XOR gate as an example)
    xor u3 (z, out1, out2);

endmodule
