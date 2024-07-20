module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always @(*) begin
    min = a; // Start with min as 'a'
    if (b < min)
        min = b; // Update if 'b' is smaller
    if (c < min)
        min = c; // Update if 'c' is smaller
    if (d < min)
        min = d; // Update if 'd' is smaller
end

endmodule
