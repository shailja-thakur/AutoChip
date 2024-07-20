module top_module(
    input x,
    input y,
    output reg z
);
    
    always @(x, y) begin
        z <= x && y; // Use logical AND operator instead of bitwise AND operator
    end

endmodule
