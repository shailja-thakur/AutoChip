module top_module (
    input [7:0] in,
    output parity
);
    
    wire [7:0] xor_out; // intermediate wire to store the XOR output
    
    assign xor_out = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0]; // calculate XOR of all 8 data bits
    
    assign parity = xor_out; // assign the parity bit to the output
    
endmodule
