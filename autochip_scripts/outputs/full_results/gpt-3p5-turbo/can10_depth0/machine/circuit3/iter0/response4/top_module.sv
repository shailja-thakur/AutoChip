module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    // Implement the OR gates
    wire ab_or = a | b;
    wire cd_or = c | d;
    
    // Implement the AND gate
    assign q = ab_or & cd_or;
endmodule
