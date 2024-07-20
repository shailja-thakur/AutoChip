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
wire [7:0] xor_output;

// XOR gates to compute the parity bit
xor_gate xor1(
    .a(in[0]),
    .b(in[1]),
    .z(xor_output[0])
);
xor_gate xor2(
    .a(in[2]),
    .b(in[3]),
    .z(xor_output[1])
);
xor_gate xor3(
    .a(in[4]),
    .b(in[5]),
    .z(xor_output[2])
);
xor_gate xor4(
    .a(xor_output[0]),
    .b(xor_output[1]),
    .z(xor_output[3])
);
xor_gate xor5(
    .a(in[6]),
    .b(in[7]),
    .z(xor_output[4])
);
xor_gate xor6(
    .a(xor_output[2]),
    .b(xor_output[3]),
    .z(xor_output[5])
);
xor_gate xor7(
    .a(xor_output[4]),
    .b(xor_output[5]),
    .z(parity)
);

endmodule
