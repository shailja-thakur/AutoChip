module top_module(
    input [7:0] p1,
    output reg p1y,
    input [7:0] p2,
    output reg p2y
);

    always @(p1 or p1a or p1b or p1c or p1d) begin
        p1y <= ~(p1a & p1b & p1c & p1d);
    end

    always @(p2 or p2a or p2b or p2c or p2d) begin
        p2y <= ~(p2a & p2b & p2c & p2d);
    end

endmodule
