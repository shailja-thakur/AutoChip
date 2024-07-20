module top_module (
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output reg [7:0] min
);

always @* begin
    min = a; // Start with 'a' as the assumed minimum
    if (b < min) begin
        min = b; // Update if 'b' is less than current min
    end
    if (c < min) begin
        min = c; // Update if 'c' is less than current min
    end
    if (d < min) begin
        min = d; // Update if 'd' is less than current min
    end
end

endmodule
