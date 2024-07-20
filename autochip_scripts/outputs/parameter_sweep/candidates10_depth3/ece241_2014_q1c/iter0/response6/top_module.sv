module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [8:0] sum;
    wire carry;

    assign sum = a + b;
    assign carry = sum[8];

    assign s = sum[7:0];
    assign overflow = carry ^ (a[7] & b[7] & ~s[7]);

endmodule
