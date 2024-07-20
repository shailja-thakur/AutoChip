module top_module (
    input [7:0] in,
    output parity
);

// Internal wires for parity calculation
wire [7:0] xor_result;
wire [6:0] xor_chain;

// Calculate XOR of all input bits
assign xor_result[0] = in[0] ^ in[1];
assign xor_result[1] = xor_result[0] ^ in[2];
assign xor_result[2] = xor_result[1] ^ in[3];
assign xor_result[3] = xor_result[2] ^ in[4];
assign xor_result[4] = xor_result[3] ^ in[5];
assign xor_result[5] = xor_result[4] ^ in[6];
assign xor_result[6] = xor_result[5] ^ in[7];

// Calculate XOR chain for generating parity bit
assign xor_chain[0] = xor_result[0] ^ xor_result[1];
assign xor_chain[1] = xor_chain[0] ^ xor_result[2];
assign xor_chain[2] = xor_chain[1] ^ xor_result[3];
assign xor_chain[3] = xor_chain[2] ^ xor_result[4];
assign xor_chain[4] = xor_chain[3] ^ xor_result[5];
assign xor_chain[5] = xor_chain[4] ^ xor_result[6];
assign xor_chain[6] = xor_chain[5] ^ in[7];

// Assign parity bit as output
assign parity = xor_chain[6];

endmodule
