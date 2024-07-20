module top_module (
	input [7:0] a,
	input [7:0] b,
	input [7:0] c,
	input [7:0] d,
	output reg [7:0] min
);

wire [7:0] min1, min2;

// Compare a and b, and assign the smaller value to min1
assign min1 = (a < b) ? a : b;

// Compare c and d, and assign the smaller value to min2
assign min2 = (c < d) ? c : d;

// Compare min1 and min2, and assign the smaller value to min
always @(*) begin
    min = (min1 < min2) ? min1 : min2;
end

endmodule
