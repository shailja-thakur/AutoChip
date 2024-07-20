module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Intermediate wires
    wire w1, w2, w3, w4;

    // First level of logic
    assign w1 = (~a & ~b & c & d) | (~a & c & ~d) | (~c & d) | (a & ~b & c);

    // Second level of logic
    assign w2 = (a & b & c) | (a & c & d);

    // Final output
    assign q = w1 | w2;
    
endmodule
