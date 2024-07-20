module top_module (
    input [2:0] in,
    output [1:0] out
);

wire [2:0] sum;

assign sum = in[0] + in[1] + in[2];
assign out = sum[1:0];

endmodule
