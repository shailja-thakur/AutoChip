module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // Logic gates to implement the desired functionality
    wire ab_Or;
    wire cd_Or;
    
    assign ab_Or = a | b;
    assign cd_Or = c | d;
    
    assign q = ab_Or & cd_Or;

endmodule
