module top_module(
    input a, 
    input b,
    input c,
    output out
);
    
    wire w1, w2, w3;

    assign w1 = a & b;
    assign w2 = ~(a & b & c);
    assign w3 = ~b & c;
    
    assign out = w1 | w2 | w3;
    
endmodule
