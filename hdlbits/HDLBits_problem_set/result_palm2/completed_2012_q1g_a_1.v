module top_module (
    input [4:1] x,
    output f
);

    logic [4:0] y;

    always @(x or y) begin
        y = or(x, y);
    end

    always @(y) begin
        f = and(y, y[2:1]);
    end

endmodule