module top_module(
    input x,
    input y,
    output reg z);

    always @(*) begin
        if ((x == 1 && y == 1) || (x == 0 && y == 0)) begin
            z = 1;
        end else begin
            z = 0;
        end
    end
endmodule
