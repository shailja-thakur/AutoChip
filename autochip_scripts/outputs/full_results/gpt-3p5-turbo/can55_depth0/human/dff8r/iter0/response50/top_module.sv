module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_reg; // New register for the previous value of q

	always @(posedge clk) begin
		if (reset)
			q_reg <= 8'b0; // Reset the q_reg to zero
		else
			q_reg <= d; // Assign the input d to q_reg
	end

	assign q = q_reg; // Assign q_reg to output q

endmodule
