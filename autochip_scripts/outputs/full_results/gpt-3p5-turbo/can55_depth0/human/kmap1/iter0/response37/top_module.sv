module top_module(
    input a,
    input b,
    input c,
    output out
);
    
    // Intermediate signals and wires
    wire w1;
    wire w2;
    
    and gate1(w1, a, b);
    or gate2(w2, w1, c);
    assign out = w2;
    
endmodule
module and(
    output wire out,
    input wire a,
    input wire b
);
    assign out = a & b;
endmodule
module or(
    output wire out,
    input wire a,
    input wire b
);
    assign out = a | b;
endmodule
