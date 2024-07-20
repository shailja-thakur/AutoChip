module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [1:0] count;

// Implement population count circuit for 3-bit input vector
assign count[0] = in[0] ^ in[1] ^ in[2];
assign count[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]);

assign out = count;

endmodule
