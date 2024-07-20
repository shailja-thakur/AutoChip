module top_module(
    input a, 
    input b,
    input c,
    output out
);
 
    wire w1, w2, w3, w4;
    
    assign w1 = a & b;
    assign w2 = a & c;
    assign w3 = b & c;
    assign w4 = w1 | w2 | w3;
    
    assign out = w4;
    
endmodule
