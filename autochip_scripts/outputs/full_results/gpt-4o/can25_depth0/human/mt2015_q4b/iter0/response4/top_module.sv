module top_module(
    input x,
    input y,
    output reg z);

    always @(*) begin
        if (x == 0 && y == 0) begin
            z = 1;
        end
        else if (x == 1 && y == 0) begin
            z = 0;
        end
        else if (x == 0 && y == 1) begin
            z = 0;
        end
        else if (x == 1 && y == 1) begin
            z = 1;
        end
    end

endmodule
