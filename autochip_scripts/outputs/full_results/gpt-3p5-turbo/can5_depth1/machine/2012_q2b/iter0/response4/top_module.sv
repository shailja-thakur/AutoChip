module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    // Declare internal wire variables
    wire y1_bit; // Wire for the first bit of y
    wire y3_or;  // Wire for the logical OR operation
    wire y3_not; // Wire for the logical NOT operation
    
    // Assign values to the wire variables
    assign y1_bit = y[0] & w;
    assign y3_or = y[1] | y[2] | y[4] | y[5];
    assign y3_not = ~w;
    
    // Output assignments
    assign Y1 = y1_bit;
    assign Y3 = y3_or & y3_not;
    
endmodule
