module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] temp1, temp2;

assign temp1[0] = in[0] ^ in[1];
assign temp1[1] = in[2];

assign temp2[0] = temp1[0] ^ temp1[1];
assign temp2[1] = temp1[0] & temp1[1];

assign out = temp2;

endmodule
