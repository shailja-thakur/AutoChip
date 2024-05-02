module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);

    wire [15:0] lower_sum;
    wire carry_out;

    add16 add16_1 (a[15:0], b[15:0], 0, lower_sum, carry_out);
    add16 add16_2 (lower_sum, carry_out, 0, sum[15:0], carry_out);

endmodule