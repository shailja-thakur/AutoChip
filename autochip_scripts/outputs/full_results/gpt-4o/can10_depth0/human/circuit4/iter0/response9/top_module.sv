module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Assign the output q based on the truth table
    assign q = (b & ~a) | c;

endmodule
