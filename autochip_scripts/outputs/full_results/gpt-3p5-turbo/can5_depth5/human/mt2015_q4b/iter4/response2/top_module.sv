module top_module(
    input x,
    input y,
    output reg z
);

    always @(x, y) begin
        #5 z <= x & y;
    end

endmodule
