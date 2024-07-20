module xor_gate (
    input a,
    input b,
    output z
);

// XOR gate implementation
assign z = a ^ b;

endmodule
module top_module (
    input [7:0] in,
    output parity
);

// Create a wire to store the XOR of all 8 data bits
wire xor_output;

// XOR gates to compute the parity bit
xor_gate xor1(
    .a(in[0]),
    .b(in[1]),
    .z(xor_output)
);
xor_gate xor2(
    .a(in[2]),
    .b(in[3]),
    .z(xor_output)
);
xor_gate xor3(
    .a(in[4]),
    .b(in[5]),
    .z(xor_output)
);
xor_gate xor4(
    .a(in[6]),
    .b(in[7]),
    .z(xor_output)
);

// Assign the output of the XOR gate to the parity output
assign parity = xor_output;

endmodule
