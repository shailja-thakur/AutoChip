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

    always @(*) begin
        // Implement the logical AND operation on the first three inputs (p1a, p1b, and p1c)
        p1y = p1a & p1b & p1c;

        // Implement the logical OR operation on the last three inputs (p1d, p1e, and p1f)
        p1y = p1y & (p1d | p1e | p1f);

        // Implement the logical AND operation on the first two inputs (p2a and p2b)
        p2y = p2a & p2b;

        // Implement the logical OR operation on the last two inputs (p2c and p2d)
        p2y = p2y & (p2c | p2d);
    end

endmodule
