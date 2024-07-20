module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Perform bitwise OR operation on inputs a and b
    wire ab_or = a | b;
    
    // Perform bitwise OR operation on inputs c and d
    wire cd_or = c | d;
    
    // Perform bitwise AND operation on the OR results
    assign q = ab_or & cd_or;
endmodule
