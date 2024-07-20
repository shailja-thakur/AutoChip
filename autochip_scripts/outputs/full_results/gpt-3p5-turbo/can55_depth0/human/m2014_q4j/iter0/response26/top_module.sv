module top_module (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

    wire [3:0] carry;
    wire [3:0] s;
    wire   cout;

    full_adder full_adder0(.a(x[0]), .b(y[0]), .cin(0), .sum(s[0]), .cout(carry[0]));
    full_adder full_adder1(.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(s[1]), .cout(carry[1]));
    full_adder full_adder2(.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(s[2]), .cout(carry[2]));
    full_adder full_adder3(.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(s[3]), .cout(cout));

    assign sum = {cout, s};

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule
