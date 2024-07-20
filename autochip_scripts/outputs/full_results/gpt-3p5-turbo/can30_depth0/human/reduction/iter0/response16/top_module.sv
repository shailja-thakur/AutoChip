module top_module (
    input [7:0] in,
    output parity
);
    wire [7:0] xor_result;

    // XOR operation for all the bits
    assign xor_result = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];

    // Calculate the parity bit
    assign parity = xor_result;

endmodule
