module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

    // Combinational logic to implement the given truth table
    assign f = (~x3 & x2) | (x3 & x1);

endmodule
