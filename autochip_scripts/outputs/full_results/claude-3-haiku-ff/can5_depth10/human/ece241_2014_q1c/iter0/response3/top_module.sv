module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] sum;

assign sum = {a[7], a} + {b[7], b};
assign s = sum[7:0];
assign overflow = sum[8] ^ sum[7];

endmodule
