module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

always @* begin
	// Initialize output to zero
	pos = 2'b00;

	// Check each input bit starting from the highest bit (bit[3])
	if (in[3] == 1'b1) pos = 2'b11;
	else if (in[2] == 1'b1) pos = 2'b10;
	else if (in[1] == 1'b1) pos = 2'b01;
	else if (in[0] == 1'b1) pos = 2'b00;
end

endmodule
