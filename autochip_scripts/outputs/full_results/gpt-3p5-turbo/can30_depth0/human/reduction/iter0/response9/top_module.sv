module top_module (
    input [7:0] in,
    output parity
);
    // Define internal signals
    wire [7:0] xor_result;
    
    // Calculate XOR of all bits
    assign xor_result[0] = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
    
    // Compute parity bit
    assign parity = xor_result[0];
    
endmodule
