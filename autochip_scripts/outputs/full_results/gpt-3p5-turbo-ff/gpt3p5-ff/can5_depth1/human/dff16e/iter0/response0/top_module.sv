module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] lower_byte_reg;
	reg [7:0] upper_byte_reg;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			// Reset all registers
			lower_byte_reg <= 8'b0;
			upper_byte_reg <= 8'b0;
		end
		else begin
			// Write to registers based on byteena input
			if (byteena[0])
				lower_byte_reg <= d[7:0];
			if (byteena[1])
				upper_byte_reg <= d[15:8];
		end
	end

	// Assign the outputs
	assign q = {upper_byte_reg, lower_byte_reg};

endmodule
