module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Declare intermediate signals
    wire w1, w2, w3, w4, w5;
    
    // Implement the logic gates
    and gate1 (w1, a, !c);
    and gate2 (w2, !b, !c, d);
    and gate3 (w3, a, b, !d);
    and gate4 (w4, !a, !b, !c);
    
    or gate5 (w5, w1, w2, w3, w4);
    
    // Assign the output
    assign out = w5;

endmodule
module and (
    output out,
    input in1,
    input in2,
    input in3 = 1'b1,
    input in4 = 1'b1
);
    assign out = in1 & in2 & in3 & in4;
endmodule
module or (
    output out,
    input in1,
    input in2,
    input in3 = 1'b0,
    input in4 = 1'b0
);
    assign out = in1 | in2 | in3 | in4;
endmodule
