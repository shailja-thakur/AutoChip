module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;  // wire for carry out of each full adder

// instantiate four full adders
full_adder fa0(
    .a(x[0]),
    .b(y[0]),
    .cin(1'b0),
    .sum(sum[0]),
    .carry(carry[0])
);
full_adder fa1(
    .a(x[1]),
    .b(y[1]),
    .cin(carry[0]),
    .sum(sum[1]),
    .carry(carry[1])
);
full_adder fa2(
    .a(x[2]),
    .b(y[2]),
    .cin(carry[1]),
    .sum(sum[2]),
    .carry(carry[2])
);
full_adder fa3(
    .a(x[3]),
    .b(y[3]),
    .cin(carry[2]),
    .sum(sum[3]),
    .carry(sum[4])  // output carry of the last full adder is assigned to the fifth bit of 'sum'
);

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output carry
);

assign sum = a ^ b ^ cin;
assign carry = (a & b) | (cin & (a ^ b));

endmodule
