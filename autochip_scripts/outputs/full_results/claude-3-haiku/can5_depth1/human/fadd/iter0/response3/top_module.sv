module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half adder for a + b
    half_adder ha1 (.a(a), .b(b), .sum(s1), .carry(c1));

    // Half adder for s1 + cin
    half_adder ha2 (.a(s1), .b(cin), .sum(sum), .carry(c2));

    // OR gate for cout
    assign cout = c1 | c2;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output carry
);

    assign sum = a ^ b;
    assign carry = a & b;

endmodule
