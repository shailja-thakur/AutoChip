module top_module(
    input x,
    input y,
    output reg z);

    always @* begin
        if (x & y) begin
            z <= 1;
        else
            z <= 0;
        end
    end

endmodule
