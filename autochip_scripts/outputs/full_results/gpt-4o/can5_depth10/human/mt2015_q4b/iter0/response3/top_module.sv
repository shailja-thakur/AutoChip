module top_module(
    input x,
    input y,
    output reg z);

    always @(*) begin
        if (x == 1'b0 && y == 1'b0) begin
            z = 1'b1;
        end else if (x == 1'b1 && y == 1'b0) begin
            z = 1'b0;
        end else if (x == 1'b0 && y == 1'b1) begin
            z = 1'b0;
        end else if (x == 1'b1 && y == 1'b1) begin
            z = 1'b1;
        end else begin
            z = 1'b1;
        end
    end
endmodule
