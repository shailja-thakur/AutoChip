module top_module (
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
    // Insert your code here
);

    logic [15:0] a1, b1, sum1, carry1;
    logic [15:0] a2, b2, sum2, carry2;

    add16 add1 (a1, b1, carry1, sum1, carry2);
    add16 add2 (a2, b2, carry2, sum2, carry1);

    assign sum = sum1 + sum2;

endmodule