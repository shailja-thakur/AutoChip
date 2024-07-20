module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Intermediate signal to hold the sum of a, b, and cin
    wire sum_ab_cin;
    
    // Calculate the sum of a, b, and cin
    assign sum_ab_cin = a + b + cin;
    
    // Calculate the carry-out bit (cout)
    assign cout = (sum_ab_cin >= 2) ? 1 : 0;
    
    // Calculate the sum output (sum) as the sum of a, b, and cin modulo 2
    assign sum = sum_ab_cin % 2;

endmodule
