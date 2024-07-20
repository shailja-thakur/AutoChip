module top_module(
    input x,
    input y,
    output reg z);

    always @(x or y) begin
        if (x == 1'b0 && y == 1'b0)
            z = 1;
        else if (x == 1'b1 && y == 1'b0)
            z = 0;
        else if (x == 1'b0 && y == 1'b1)
            z = 0;
        else if (x == 1'b1 && y == 1'b1)
            z = 1;
    end
endmodule
