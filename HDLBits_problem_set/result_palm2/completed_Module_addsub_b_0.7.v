module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    Add16 adder1 (.a(a[15:0]), .b(b[15:0]), .cin(1'b0), .sum(sum[15:0]), .cout(cout[15:0]));
    Add16 adder2 (.a(a[31:16]), .b(b_inv[31:16]), .cin(cout[15:0]), .sum(sum[31:16]), .cout(cout[31:16]));
endmodule