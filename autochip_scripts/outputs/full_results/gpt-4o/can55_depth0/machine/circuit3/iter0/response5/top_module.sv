module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire or_ab;
    wire or_cd;
    
    // OR operation on inputs a and b
    assign or_ab = a | b;
    
    // OR operation on inputs c and d
    assign or_cd = c | d;
    
    // AND operation on the results of the OR operations
    assign q = or_ab & or_cd;

endmodule
