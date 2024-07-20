module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    
    wire w1, w2, w3, w4, w5, w6;
    
    // Intermediate signals
    and gate1(w1, a, b);
    and gate2(w2, c, d);
    and gate3(w3, c, a);
    and gate4(w4, b, d);
    or gate5(w5, w1, w2, w3);
    or gate6(w6, w3, w4);
    
    // Output
    assign out = w5 | w6;
    
endmodule
module and (
    output wire p, 
    input wire a,
    input wire b
);
    assign p = a & b;
endmodule
module or (
    output wire p, 
    input wire a,
    input wire b,
    input wire c
);
    assign p = a | b | c;
endmodule
