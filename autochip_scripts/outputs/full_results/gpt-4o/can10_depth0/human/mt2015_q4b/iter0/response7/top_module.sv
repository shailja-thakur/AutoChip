module top_module(
    input x,
    input y,
    output reg z
);

    always @(*) begin
        if (x == 0 && y == 0)
            z = 1;
        else if (x == 1 && y == 0)
            z = 0;
        else if (x == 0 && y == 1)
            z = 0;
        else if (x == 1 && y == 1)
            z = 1;
    end

endmodule
