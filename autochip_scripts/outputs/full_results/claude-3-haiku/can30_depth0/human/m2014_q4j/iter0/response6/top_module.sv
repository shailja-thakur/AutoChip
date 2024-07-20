module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire c1, c2, c3;

full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum[0]), .cout(c1));
full_adder fa1 (.a(x[1]), .b(y[1]), .cin(c1), .sum(sum[1]), .cout(c2));
full_adder fa2 (.a(x[2]), .b(y[2]), .cin(c2), .sum(sum[2]), .cout(c3));
full_adder fa3 (.a(x[3]), .b(y[3]), .cin(c3), .sum(sum[3]), .cout(sum[4]));

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

wire s1, c1, c2;

half_adder ha1 (.a(a), .b(b), .sum(s1), .cout(c1));
half_adder ha2 (.a(s1), .b(cin), .sum(sum), .cout(c2));
assign cout = c1 | c2;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);

assign sum = a ^ b;
assign cout = a & b;

endmodule
