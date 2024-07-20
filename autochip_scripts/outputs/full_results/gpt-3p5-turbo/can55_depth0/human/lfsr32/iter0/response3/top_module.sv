module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] shift_reg;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 32'h1;
		end else begin
			shift_reg <= {shift_reg[30:0], shift_reg[22] ^ shift_reg[2] ^ shift_reg[1] ^ shift_reg[0]};
		end
	end
	
	// Output assignment
	assign q = shift_reg;
	
endmodule
