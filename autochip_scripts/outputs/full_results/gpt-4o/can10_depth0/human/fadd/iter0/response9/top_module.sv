module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    
    // Internal wire to hold the intermediate sum
    wire ab_sum;
    wire ab_carry;
    wire sum_carry;

    // Sum of a and b
    assign ab_sum = a ^ b;
    
    // Carry from a and b
    assign ab_carry = a & b;
    
    // Final sum and carry-out
    assign sum = ab_sum ^ cin;
    assign sum_carry = ab_sum & cin;
    assign cout = ab_carry | sum_carry;

endmodule
