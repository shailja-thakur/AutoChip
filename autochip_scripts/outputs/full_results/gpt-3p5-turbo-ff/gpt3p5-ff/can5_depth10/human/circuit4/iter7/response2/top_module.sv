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
    assign w1 = (~a & ~b & c & d) | (~a & c & ~d);

    // Second level of logic
    assign w2 = (a & ~b & c & d) | (~a & b & c & d) | (a & b & ~c & d);

    // Third level of logic
    assign w3 = (~c & d) | (a & ~b & c);

    // Final output
    assign q = w1 | w2 | w3;
    
endmodule
