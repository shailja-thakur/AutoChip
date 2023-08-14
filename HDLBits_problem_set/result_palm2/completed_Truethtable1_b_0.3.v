module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    // AND gate 1
    wire a1 = x3 & x2 & x1;

    // AND gate 2
    wire a2 = x3 & x2 & ~x1;

    // AND gate 3
    wire a3 = x3 & ~x2 & x1;

    // AND gate 4
    wire a4 = x3 & ~x2 & ~x1;

    // OR gate
    wire f = a1 | a2 | a3 | a4;

endmodule