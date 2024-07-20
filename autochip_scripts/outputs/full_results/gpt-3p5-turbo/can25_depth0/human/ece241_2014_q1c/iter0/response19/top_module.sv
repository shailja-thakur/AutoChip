module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    reg [7:0] sum;
    wire carry;

    assign {carry, sum} = a + b;
    assign s = sum;
    assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);

endmodule
