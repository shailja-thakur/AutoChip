module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [2:0] count;

assign count[0] = in[0] ^ in[1] ^ in[2];
assign count[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]);
assign count[2] = (in[0] & in[1] & in[2]);

assign out = count[1:0];

endmodule
