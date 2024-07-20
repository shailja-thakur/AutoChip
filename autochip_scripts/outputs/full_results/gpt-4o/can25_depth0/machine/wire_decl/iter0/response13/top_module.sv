module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

    wire w1, w2;
    
    // Compute the AND of a and b
    assign w1 = a & b;
    
    // Compute the AND of c and d
    assign w2 = c & d;
    
    // Compute the OR of w1 and w2
    assign out = w1 | w2;
    
    // Compute the NOT of out
    assign out_n = ~out;

endmodule
