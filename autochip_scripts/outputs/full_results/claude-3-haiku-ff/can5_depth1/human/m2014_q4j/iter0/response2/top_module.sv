module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] intermediate_sums;
wire [3:0] intermediate_carries;

full_adder FA0 (
    .a(x[0]),
    .b(y[0]),
    .cin(1'b0),
    .sum(intermediate_sums[0]),
    .cout(intermediate_carries[0])
);

full_adder FA1 (
    .a(x[1]),
    .b(y[1]),
    .cin(intermediate_carries[0]),
    .sum(intermediate_sums[1]),
    .cout(intermediate_carries[1])
);

full_adder FA2 (
    .a(x[2]),
    .b(y[2]),
    .cin(intermediate_carries[1]),
    .sum(intermediate_sums[2]),
    .cout(intermediate_carries[2])
);

full_adder FA3 (
    .a(x[3]),
    .b(y[3]),
    .cin(intermediate_carries[2]),
    .sum(intermediate_sums[3]),
    .cout(intermediate_carries[3])
);

assign sum = {intermediate_carries[3], intermediate_sums};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

assign sum = a ^ b ^ cin;
assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
