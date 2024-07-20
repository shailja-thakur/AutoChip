module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    
    wire ab_or, cd_or;
    wire q_and;
    
    assign ab_or = a | b;
    assign cd_or = c | d;
    assign q_and = ab_or & cd_or;
    
    assign q = q_and;
    
endmodule
