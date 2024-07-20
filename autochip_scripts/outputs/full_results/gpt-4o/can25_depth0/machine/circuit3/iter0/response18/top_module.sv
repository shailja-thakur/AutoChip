module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or1, or2;

    // OR of inputs a and b
    assign or1 = a | b;

    // OR of inputs c and d
    assign or2 = c | d;

    // AND of the two OR results
    assign q = or1 & or2;
    
endmodule
