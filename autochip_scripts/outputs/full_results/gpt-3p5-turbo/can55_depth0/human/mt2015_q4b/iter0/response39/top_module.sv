module top_module(
    input x,
    input y,
    output z);

    reg z;
    always @(x or y) begin
        if (x == 1'b1 && y == 1'b0)
            z = 1'b0;
        else if (y == 1'b1 && x == 1'b0)
            z = 1'b0;
        else
            z = 1'b1;
    end

endmodule
