module top_module(
    input x,
    input y,
    output z
);

    reg z;

    always @(*) begin
        if (x & y)
            z = 1;
        else
            z = 0;
    end

endmodule
