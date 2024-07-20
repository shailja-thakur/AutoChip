module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // Declare intermediate signals
    wire w1, w2, w3, w4;
    
    // Implement the logic gates
    nand_gate gate1 (w1, a, ~c);
    nand_gate gate2 (w2, ~b, ~c, d);
    nand_gate gate3 (w3, a, b, ~d);
    nand_gate gate4 (w4, ~a, ~b, ~c);
    
    // Implement the final logic
    or_gate final_gate (out, w1, w2, w3, w4);

endmodule
module nand_gate (
    output out,
    input in1,
    input in2,
    input in3 = 1'b1,
    input in4 = 1'b1
);
    assign out = ~(in1 & in2 & in3 & in4);
endmodule
module or_gate (
    output out,
    input in1,
    input in2,
    input in3 = 1'b0,
    input in4 = 1'b0
);
    assign out = in1 | in2 | in3 | in4;
endmodule
