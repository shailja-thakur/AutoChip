module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

wire [8:0] temp_sum;

assign temp_sum = {a[7], a} + {b[7], b};
assign s = temp_sum[7:0];
assign overflow = (a[7] == b[7]) && (a[7] != temp_sum[7]);

endmodule
