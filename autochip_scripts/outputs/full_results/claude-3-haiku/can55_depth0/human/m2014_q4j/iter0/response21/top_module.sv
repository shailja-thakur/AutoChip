module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;

full_adder FA0 (
    .a(x[0]),
    .b(y[0]),
    .cin(1'b0),
    .s(sum[0]),
    .cout(carry[0])
);

full_adder FA1 (
    .a(x[1]),
    .b(y[1]),
    .cin(carry[0]),
    .s(sum[1]),
    .cout(carry[1])
);

full_adder FA2 (
    .a(x[2]),
    .b(y[2]),
    .cin(carry[1]),
    .s(sum[2]),
    .cout(carry[2])
);

full_adder FA3 (
    .a(x[3]),
    .b(y[3]),
    .cin(carry[2]),
    .s(sum[3]),
    .cout(carry[3])
);

assign sum[4] = carry[3];

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output s,
    output cout
);

wire s1, c1, c2;

half_adder HA1 (
    .a(a),
    .b(b),
    .s(s1),
    .cout(c1)
);

half_adder HA2 (
    .a(s1),
    .b(cin),
    .s(s),
    .cout(c2)
);

assign cout = c1 | c2;

endmodule
module half_adder (
    input a,
    input b,
    output s,
    output cout
);

assign s = a ^ b;
assign cout = a & b;

endmodule
