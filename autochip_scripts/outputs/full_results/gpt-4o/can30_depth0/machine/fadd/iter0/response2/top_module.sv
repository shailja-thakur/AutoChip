module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Intermediate signal for the raw sum result
    wire raw_sum;
    
    // Add the inputs including carry-in
    assign raw_sum = a + b + cin;
    
    // The sum is the lower bit of the raw_sum
    assign sum = raw_sum[0];
    
    // The carry-out is the second bit of the raw_sum
    assign cout = raw_sum[1];

endmodule
