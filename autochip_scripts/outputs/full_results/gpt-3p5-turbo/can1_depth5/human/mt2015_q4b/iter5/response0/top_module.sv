module top_module(
    input x,
    input y,
    output reg z); // Declare z as reg

    always @(x or y) begin
        if (x == 1'b1 && y == 1'b1) // Use equality operator instead of logical AND
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
