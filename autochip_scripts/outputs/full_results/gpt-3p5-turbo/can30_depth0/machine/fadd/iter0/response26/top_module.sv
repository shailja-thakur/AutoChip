module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal wire to calculate sum
    wire[1:0] sum_internal = a + b + cin;
    
    // Calculate cout
    assign cout = (sum_internal >= 2) ? 1'b1 : 1'b0;
    
    // Calculate sum
    assign sum = sum_internal[0];

endmodule
