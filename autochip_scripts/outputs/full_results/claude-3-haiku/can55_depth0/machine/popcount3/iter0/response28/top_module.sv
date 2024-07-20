module top_module (
    input [2:0] in,
    output [1:0] out
);

    wire [2:0] sum;
    assign sum = in[0] + in[1] + in[2];
    assign out[0] = sum[0];
    assign out[1] = sum[1];

endmodule
