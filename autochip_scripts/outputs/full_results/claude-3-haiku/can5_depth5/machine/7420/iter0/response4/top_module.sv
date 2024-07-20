module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

wire p1_and, p2_and;

// 4-input AND gate for p1y
assign p1_and = p1a & p1b & p1c & p1d;

// Invert the p1y output
assign p1y = ~p1_and;

// 4-input AND gate for p2y  
assign p2_and = p2a & p2b & p2c & p2d;

// Invert the p2y output
assign p2y = ~p2_and;

endmodule
