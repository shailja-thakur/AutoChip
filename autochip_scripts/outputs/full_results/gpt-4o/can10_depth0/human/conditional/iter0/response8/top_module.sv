module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

always @(*) begin
    // Start by assuming 'a' is the smallest
    min = a;
    // Compare 'min' with 'b' and update 'min' if 'b' is smaller
    if (b < min) min = b;
    // Compare 'min' with 'c' and update 'min' if 'c' is smaller
    if (c < min) min = c;
    // Compare 'min' with 'd' and update 'min' if 'd' is smaller
    if (d < min) min = d;
end

endmodule
