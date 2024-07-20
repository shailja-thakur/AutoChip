module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    wire or1, or2;
    
    assign or1 = a | b;
    assign or2 = c | d;
    assign q = or1 & or2;

endmodule
