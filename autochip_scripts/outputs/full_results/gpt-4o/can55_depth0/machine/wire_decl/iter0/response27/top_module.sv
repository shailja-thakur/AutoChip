module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);
    
    // Intermediate wires
    wire w1;
    wire w2;
    
    // Assigning the logical AND of inputs a and b to w1
    assign w1 = a & b;
    
    // Assigning the logical AND of inputs c and d to w2
    assign w2 = c & d;
    
    // Assigning the logical OR of w1 and w2 to out
    assign out = w1 | w2;
    
    // Assigning the logical NOT of out to out_n
    assign out_n = ~out;
    
endmodule
