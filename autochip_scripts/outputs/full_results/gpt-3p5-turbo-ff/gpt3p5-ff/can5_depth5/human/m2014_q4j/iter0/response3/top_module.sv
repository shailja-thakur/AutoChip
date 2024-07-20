module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] carry;
    wire overflow;

    // Instantiate four full adders for each bit position
    full_adder fa0(.a(x[0]), .b(y[0]), .cin(0), .sum(sum[0]), .cout(carry[0]));
    full_adder fa1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
    full_adder fa2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
    full_adder fa3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

    // Calculate overflow bit by checking if carry out of MSB is set
    assign overflow = carry[3] & (carry[2] | carry[1] | carry[0]);

    // Append carry to the sum output
    assign sum[4] = overflow;
endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    wire s1, c1, c2;

    // Calculate sum and carry out
    assign s1 = a ^ b;
    assign c1 = a & b;
    assign sum = s1 ^ cin;
    assign c2 = s1 & cin;

    // Calculate carry out
    assign cout = c1 | c2;
endmodule
