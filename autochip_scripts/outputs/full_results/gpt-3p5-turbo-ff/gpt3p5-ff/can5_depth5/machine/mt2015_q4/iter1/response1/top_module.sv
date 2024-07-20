module top_module(
    input x,
    input y,
    output z);

    // Define internal wires
    wire a, b;

    // First gate
    assign a = x & ~y;

    // Second gate
    assign b = y & ~x;

    // Third gate
    assign z = a & b;
endmodule
