module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Intermediate wire to store the sum of a, b, and cin
    wire intermediate_sum;
    
    // Calculate the intermediate sum
    assign intermediate_sum = a + b + cin;
    
    // Calculate the sum output (result of addition modulo 2)
    assign sum = intermediate_sum % 2;
    
    // Calculate the carry-out bit (if intermediate sum is greater than or equal to 2)
    assign cout = (intermediate_sum >= 2) ? 1 : 0;
    
endmodule
