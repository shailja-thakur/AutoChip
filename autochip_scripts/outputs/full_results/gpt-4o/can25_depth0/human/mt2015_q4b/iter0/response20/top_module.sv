module top_module(
    input x,
    input y,
    output reg z);

    always @(x or y) begin
        if ((x == 0 && y == 0) || (x == 1 && y == 1)) begin
            z = 1;
        end else begin
            z = 0;
        end
    end

endmodule
