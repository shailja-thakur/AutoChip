module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Create internal register for LFSR
	reg [31:0] lfsr_reg;

	// Assign initial value for lfsr_reg
	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr_reg <= 32'h1;
		else begin
			// Calculate new lfsr_reg value based on tap positions
			lfsr_reg <= {lfsr_reg[30:0], lfsr_reg[31] ^ lfsr_reg[21] ^ lfsr_reg[1] ^ lfsr_reg[0]};
		end
	end

	// Assign output q with lfsr_reg value
	assign q = lfsr_reg;

endmodule
