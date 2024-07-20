module top_module (
	input clk,
	input resetn,
	input in,
	output reg out
);

	// 4-bit shift register
	reg [3:0] sr;

	always @(posedge clk) begin
		if (resetn == 0) begin
			sr <= 4'b0; // Reset to all zeros
		end else begin
			sr <= {sr[2:0], in}; // Shift left and load input
		end
	end

	assign out = sr[3]; // Output from most significant bit

endmodule
