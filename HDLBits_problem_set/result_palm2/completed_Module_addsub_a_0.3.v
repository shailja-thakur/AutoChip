module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire [31:0] b_inv;
    xor16 b_inv_xor (b_inv, b, sub);
    add16 add1 (a, b_inv, 1'b0, sum, cout);
endmodule