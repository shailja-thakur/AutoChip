module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always @(*) begin
    min = a; // Initially assign min to a

    if (b < min)
        min = b; // Update min if b is smaller than current min

    if (c < min)
        min = c; // Update min if c is smaller than current min

    if (d < min)
        min = d; // Update min if d is smaller than current min
end

endmodule
