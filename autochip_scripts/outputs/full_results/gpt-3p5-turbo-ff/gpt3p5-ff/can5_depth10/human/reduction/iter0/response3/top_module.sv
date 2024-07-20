module top_module (
    input [7:0] in,
    output parity
);

// Internal wire for storing the computed parity bit
wire computed_parity;

// XOR gate to compute the parity bit
assign computed_parity = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

// Assigning the computed parity bit to the output port
assign parity = computed_parity;

endmodule
