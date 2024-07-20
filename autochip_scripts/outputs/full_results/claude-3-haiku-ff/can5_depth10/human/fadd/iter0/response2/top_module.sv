module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire half_sum1, half_sum2, half_cout1, half_cout2;

    // First half adder
    assign half_sum1 = a ^ b;
    assign half_cout1 = a & b;

    // Second half adder
    assign half_sum2 = half_sum1 ^ cin;
    assign half_cout2 = half_sum1 & cin;

    // Final output
    assign sum = half_sum2;
    assign cout = half_cout1 | half_cout2;

endmodule
