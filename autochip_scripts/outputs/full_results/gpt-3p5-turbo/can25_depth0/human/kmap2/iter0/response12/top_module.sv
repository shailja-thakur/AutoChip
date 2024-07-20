module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    
    wire w1, w2, w3, w4, w5, w6;
    
    assign w1 = a & ~b & ~c & ~d;
    assign w2 = a & ~b & ~c & d;
    assign w3 = ~a & b & c & d;
    assign w4 = a & ~b & c & d;
    assign w5 = a & b;
    assign w6 = a & ~c;

    assign out = w1 | w2 | w3 | w4 | w5 | w6;
    
endmodule
