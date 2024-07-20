module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire overflow;      // declare a wire for overflow
    
    assign s = a + b;   // assign the sum of a and b to s
    
    // check for overflow
    assign overflow = ((a[7] && b[7] && !s[7]) || (!a[7] && !b[7] && s[7]));
endmodule
