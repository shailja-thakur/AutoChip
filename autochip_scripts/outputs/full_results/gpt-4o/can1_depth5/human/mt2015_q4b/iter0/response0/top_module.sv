module top_module(
    input x,
    input y,
    output reg z);

    always @* begin
        if (x == 1'b0 && y == 1'b0)
            z = 1'b1;
        else if (x == 1'b1 && y == 1'b0)
            z = 1'b0;
        else if (x == 1'b0 && y == 1'b1)
            z = 1'b0;
        else if (x == 1'b1 && y == 1'b1)
            z = 1'b1;
        else
            z = 1'b1; // default case, should not normally occur
    end
endmodule
