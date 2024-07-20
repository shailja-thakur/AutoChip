module top_module(
    input x,
    input y,
    output z);
    
    wire out1, out2;

    // First gate logic
    assign out1 = x & y; // AND gate (can be replaced with any other gate as per requirement)

    // Second gate logic
    assign out2 = x | y; // OR gate (can be replaced with any other gate as per requirement)

    // Third gate logic
    assign z = out1 ^ out2; // XOR gate (can be replaced with any other gate as per requirement)

endmodule
