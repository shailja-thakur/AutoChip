module top_module (
    input a,
    input b,
    output sum,
    output cout
);
    wire [1:0] result; // Declare a wire to hold the result of the addition
    
    // Add the two inputs together and assign the result to the 'result' wire
    assign result = a + b;
    
    // Separate the sum and carry out from the 'result' wire
    assign sum = result[0];
    assign cout = result[1];
    
endmodule
