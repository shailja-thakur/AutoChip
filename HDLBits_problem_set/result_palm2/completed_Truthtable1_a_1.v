module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    AND gate and1 (x3, x2, f);
    AND gate and2 (x3, x1, f);
    AND gate and3 (x2, x1, f);
    OR gate or1 (and1.f, and2.f, f);
    OR gate or2 (and3.f, or1.f, f);

endmodule