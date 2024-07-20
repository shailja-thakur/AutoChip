module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output reg p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output reg p2y
);

    // First output p1y
    always @(*) begin
        p1y = (p1a & p1b & p1c) | (p1d | p1e | p1f);
    end

    // Second output p2y
    always @(*) begin
        p2y = (p2a & p2b) | (p2c | p2d);
    end

endmodule
