module top_module (
    input [7:0] in,
    output parity
);
 
wire [7:0] xor_out;
 
// Compute XOR of all input bits
assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

// Compute even parity
assign parity = ~xor_out;

endmodule
