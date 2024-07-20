module top_module (
    input [7:0] in,
    output parity
);

// Declaration of wires
wire [7:0] in_xor;
wire parity_bit;

// XOR gates for computing the parity bit
assign in_xor = ^in;
assign parity_bit = ^in_xor;

// Output assignment
assign parity = parity_bit;
endmodule
