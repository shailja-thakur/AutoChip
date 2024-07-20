module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire ab_or;
    wire cd_or;
    
    // Perform bitwise OR on a and b, c and d
    assign ab_or = a | b;
    assign cd_or = c | d;
    
    // Perform bitwise AND on the results of the above OR operations
    assign q = ab_or & cd_or;

endmodule
