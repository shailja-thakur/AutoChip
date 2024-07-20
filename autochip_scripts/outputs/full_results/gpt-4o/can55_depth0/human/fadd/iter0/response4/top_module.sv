module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Internal single-bit signals for intermediate sum and carry
    wire sum1, carry1, carry2;

    // First half adder (adds a and b)
    assign sum1 = a ^ b;
    assign carry1 = a & b;

    // Second half adder (adds sum1 and cin)
    assign sum = sum1 ^ cin;
    assign carry2 = sum1 & cin;

    // OR gate to produce the final carry-out
    assign cout = carry1 | carry2;

endmodule
