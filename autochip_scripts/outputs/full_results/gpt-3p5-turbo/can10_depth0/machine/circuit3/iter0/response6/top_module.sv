module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Intermediate signals
    wire ab_or;
    wire cd_or;
    
    // Logic gates
    assign ab_or = a | b;
    assign cd_or = c | d;
    assign q = ab_or & cd_or;

endmodule
