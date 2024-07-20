module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);
    
    // Assign the result of a AND b to out_assign using an assign statement
    assign out_assign = a & b;
    
    // Always block to assign the result of a AND b to out_alwaysblock
    always @(*) begin
        out_alwaysblock = a & b;
    end

endmodule
