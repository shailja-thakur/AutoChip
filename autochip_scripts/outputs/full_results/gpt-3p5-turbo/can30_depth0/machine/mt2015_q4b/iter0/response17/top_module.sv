module top_module(
    input x,
    input y,
    output z
);

// Internal wires
wire xor_out;

// XOR gate for x and y
xor(xor_out, x, y);

// Logical negation of the XOR output
not z_out(z, xor_out);

endmodule
