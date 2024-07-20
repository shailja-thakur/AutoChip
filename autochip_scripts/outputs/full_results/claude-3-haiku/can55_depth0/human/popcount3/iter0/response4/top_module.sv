module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [2:0] temp;

assign temp[0] = in[0];
assign temp[1] = in[0] ^ in[1];
assign temp[2] = (in[0] & in[1]) | in[2];

assign out[0] = temp[0] | temp[1] | temp[2];
assign out[1] = (temp[1] & temp[2]) | (temp[0] & temp[2]) | (temp[0] & temp[1]);

endmodule
