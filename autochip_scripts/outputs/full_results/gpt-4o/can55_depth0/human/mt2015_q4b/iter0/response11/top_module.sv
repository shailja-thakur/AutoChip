module top_module(
    input x,
    input y,
    output reg z
);

always @(*) begin
    // The module's behavior can be described as:
    // If x and y are both 1, z is 1.
    // If only x is 1, z is 0.
    // If only y is 1, z is 0.
    // If both x and y are 0, z is 1.
    
    if (x && y)
        z = 1;
    else if (x)
        z = 0;
    else if (y)
        z = 0;
    else
        z = 1;
end

endmodule
