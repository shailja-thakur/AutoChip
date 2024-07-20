module top_module (
	input [99:0] in,
	output reg [99:0] out
);
	// Wire to connect the reversed bits
	wire [99:0] reversed;

	// Generate the reversed bits
	assign reversed = {in[99:0]};

	// Assign the reversed bits to output
	always @(reversed)
		begin
			out <= reversed;
		end
endmodule
