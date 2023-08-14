module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
    // Insert your code here
);//

    add1 u1 (a[15:0], b[15:0], 1'b0, sum[15:0], cout[15:0]);
    add1 u2 (a[31:16], b[31:16], cout[15:0], sum[31:16], cout[31:16]);

endmodule