module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire c1, c2, c3;

fulladder fa0 (
    .a(x[0]),
    .b(y[0]),
    .cin(1'b0),
    .sum(sum[0]),
    .cout(c1)
);

fulladder fa1 (
    .a(x[1]),
    .b(y[1]),
    .cin(c1),
    .sum(sum[1]),
    .cout(c2)
);

fulladder fa2 (
    .a(x[2]),
    .b(y[2]),
    .cin(c2),
    .sum(sum[2]),
    .cout(c3)
);

fulladder fa3 (
    .a(x[3]),
    .b(y[3]),
    .cin(c3),
    .sum(sum[3]),
    .cout(sum[4])
);

endmodule
module fulladder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
