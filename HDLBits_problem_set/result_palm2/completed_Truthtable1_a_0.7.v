module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    // OR gate: A + B + C = 1 if any of A, B, or C are 1
    assign f = (x3 | x2 | x1);

endmodule