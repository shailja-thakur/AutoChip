module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;
wire [3:0] xor_out;
assign {carry[3], xor_out[3:0]} = x[3:0] + y[3:0];

fulladder FA0 (
    .a(x[0]),
    .b(y[0]),
    .cin(0),
    .sum(sum[0]),
    .carry(carry[0])
);

fulladder FA1 (
    .a(x[1]),
    .b(y[1]),
    .cin(carry[0]),
    .sum(sum[1]),
    .carry(carry[1])
);

fulladder FA2 (
    .a(x[2]),
    .b(y[2]),
    .cin(carry[1]),
    .sum(sum[2]),
    .carry(carry[2])
);

fulladder FA3 (
    .a(x[3]),
    .b(y[3]),
    .cin(carry[2]),
    .sum(sum[3]),
    .carry(carry[3])
);

assign sum[4] = carry[3];

endmodule
