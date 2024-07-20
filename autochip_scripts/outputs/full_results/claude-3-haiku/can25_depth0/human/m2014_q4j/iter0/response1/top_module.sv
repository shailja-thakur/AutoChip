module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;

full_adder fa0 (
    .a(x[0]),
    .b(y[0]),
    .c_in(1'b0),
    .sum(sum[0]),
    .c_out(carry[0])
);

full_adder fa1 (
    .a(x[1]),
    .b(y[1]),
    .c_in(carry[0]),
    .sum(sum[1]),
    .c_out(carry[1])
);

full_adder fa2 (
    .a(x[2]),
    .b(y[2]),
    .c_in(carry[1]),
    .sum(sum[2]),
    .c_out(carry[2])
);

full_adder fa3 (
    .a(x[3]),
    .b(y[3]),
    .c_in(carry[2]),
    .sum(sum[3]),
    .c_out(sum[4])
);

endmodule
module full_adder (
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
);

wire s1, c1, c2;

half_adder ha1 (
    .a(a),
    .b(b),
    .sum(s1),
    .c_out(c1)
);

half_adder ha2 (
    .a(s1),
    .b(c_in),
    .sum(sum),
    .c_out(c2)
);

assign c_out = c1 | c2;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output c_out
);

assign sum = a ^ b;
assign c_out = a & b;

endmodule
