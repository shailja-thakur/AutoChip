module top_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);

    AND gate and1 (x3, x2, y1);
    AND gate and2 (x3, x1, y2);
    AND gate and3 (x2, x1, y3);
    OR gate or1 (y1, y2, y3, f);

endmodule