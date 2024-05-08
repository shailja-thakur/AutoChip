module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    // Instantiate two 16-bit adders.
    add16 add1 (a[15:0], b[15:0], 1'b0, sum[15:0], cout[1]);
    add16 add2 (a[31:16], b[31:16], cout[1], sum[31:16], cout[0]);

    // Connect the sub input to the carry-in of the adders.
    add1.cin = sub;
    add2.cin = sub;

endmodule