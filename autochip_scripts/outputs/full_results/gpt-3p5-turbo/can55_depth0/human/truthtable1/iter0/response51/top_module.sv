module top_module (
    input x3,
    input x2,
    input x1,
    output f
);
    
    // Assign output 'f' based on the truth table
    assign f = (x1 & ~x3) | (x2 & ~x3) | (x1 & x2 & ~x3) | (x1 & x2 & x3);
    
endmodule
