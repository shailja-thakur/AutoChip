module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire c1, c2, s1;

    // Half adder for a and b
    half_adder h1 (.a(a), .b(b), .sum(s1), .carry(c1));

    // Half adder for s1 and cin
    half_adder h2 (.a(s1), .b(cin), .sum(sum), .carry(c2));

    // OR gate for carry-out
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
