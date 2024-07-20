module top_module(
    input x,
    input y,
    output reg z);

    always @(*) begin
        if (x && y) begin
            z <= 1;
        end else if (x) begin
            z <= 0;
        end else if (y) begin
            z <= 0;
        end else begin
            z <= 1;
        end
    end
endmodule
