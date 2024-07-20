module top_module(
    input x,
    input y,
    output z);

    reg z;

    always @(x or y) begin
        if (x & !y)
            z <= 1'b0;
        else if (!x & y)
            z <= 1'b0;
        else if (x & y)
            z <= 1'b1;
    end
endmodule
