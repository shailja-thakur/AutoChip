module top_module (
    input [7:0] in,
    output parity
);
    wire [8:0] temp;
    assign temp = {in, in[7:0]};
    assign parity = temp[0] ^ temp[1] ^ temp[2] ^ temp[3] ^ temp[4] ^ temp[5] ^ temp[6] ^ temp[7] ^ temp[8];
    
endmodule
