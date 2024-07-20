module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);
    reg Y2_reg, Y4_reg;

    assign Y2 = Y2_reg;
    assign Y4 = Y4_reg;

    always @*
    begin
        Y2_reg = y[1] & ~w;
        Y4_reg = y[6] & y[5] & y[3] & y[2] & w;
    end

endmodule
