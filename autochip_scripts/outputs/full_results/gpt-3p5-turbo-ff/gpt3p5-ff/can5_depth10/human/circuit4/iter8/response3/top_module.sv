module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Intermediate wires
    wire w1, w2, w3;

    // First level of logic
    assign w1 = (~a & ~b & c & ~d) | (~a & c);

    // Second level of logic
    assign w2 = (a & ~b & c) | (~c & d);

    // Third level of logic
    assign w3 = (~a & b & c) | (a & b & c);

    // Final output
    assign q = w1 | w2 | w3;
    
endmodule
