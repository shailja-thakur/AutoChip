module top_module (
    input [99:0] in,
    output out_and,
    output out_or,
    output out_xor
);

// Compute the AND of all 100 inputs
assign out_and = &in;

// Compute the OR of all 100 inputs
assign out_or = |in;

// Compute the XOR of all 100 inputs
// Use a tree structure to compute the XOR
wire [49:0] xor1, xor2;
genvar i;
generate
    for (i = 0; i < 50; i = i + 1) begin
        assign xor1[i] = in[i*2] ^ in[i*2+1];
    end
    for (i = 0; i < 25; i = i + 1) begin
        assign xor2[i] = xor1[i*2] ^ xor1[i*2+1];
    end
    assign out_xor = xor2[0] ^ xor2[1] ^ xor2[2] ^ xor2[3] ^ xor2[4] ^ xor2[5] ^ xor2[6] ^ xor2[7] ^ xor2[8] ^ xor2[9] ^ xor2[10] ^ xor2[11] ^ xor2[12] ^ xor2[13] ^ xor2[14] ^ xor2[15] ^ xor2[16] ^ xor2[17] ^ xor2[18] ^ xor2[19] ^ xor2[20] ^ xor2[21] ^ xor2[22] ^ xor2[23] ^ xor2[24];
endgenerate

endmodule
