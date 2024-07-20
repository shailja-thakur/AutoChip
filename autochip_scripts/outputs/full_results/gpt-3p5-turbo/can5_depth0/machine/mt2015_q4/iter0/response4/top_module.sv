module top_module(
    input x,
    input y,
    output z
    );
    
    wire x_and_y;
    wire x_or_y;
    wire x_and_y_nor;
    
    assign x_and_y = x & y;
    assign x_or_y = x | y;
    assign x_and_y_nor = ~(x_and_y | x_or_y);
    
    assign z = x_and_y_nor;
    
endmodule
