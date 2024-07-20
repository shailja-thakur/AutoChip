module top_module (
    input [7:0] in,
    output parity
);
    // Define internal wire for the XOR operation
    wire [7:0] xor_result;
    
    // Compute the XOR operation for all 8 data bits
    assign xor_result = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];
    
    // Output the parity bit
    assign parity = xor_result;
    
endmodule
