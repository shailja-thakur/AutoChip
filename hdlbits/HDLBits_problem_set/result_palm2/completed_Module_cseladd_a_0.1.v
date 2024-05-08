module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    add16 add16_0 (a[15:0], b[15:0], 1'b0, sum[15:0], cout[0]);
    add16 add16_1 (a[31:16], b[31:16], cout[0], sum[31:16], cout[1]);
    add16 add16_2 (cout[1], 1'b0, cout[1], sum[31], cout[2]);

    assign sum[31:16] = add16_0.sum;
    assign sum[15:0] = add16_1.sum;
    assign sum[0] = add16_2.sum;

endmodule