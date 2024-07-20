module top_module(
    input [1:0] A,
    input [1:0] B,
    output z);
    
    // Create a wire to store the result of the comparison
    wire equal;
    
    // Use an equality operator to compare A and B
    // The result will be stored in the 'equal' wire
    assign equal = (A == B);
    
    // Assign the value of 'equal' to the output 'z'
    assign z = equal;
    
endmodule
