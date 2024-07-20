module top_module (
    input [7:0] in,
    output parity
);

wire [8:0] concat_in;
wire xor_out;

assign concat_in = {in, xor_out};
assign xor_out = in[0] ^ in[1] ^ in[2] ^ in[3] ^ in[4] ^ in[5] ^ in[6] ^ in[7];

assign parity = xor_out;

endmodule
