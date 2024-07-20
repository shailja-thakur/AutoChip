module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	// Declare a wire to store the shifted data
	wire [3:0] shifted_data;
	
	// Internal register to hold the current value of q
	reg [3:0] q_reg;
	
	always @(posedge clk) begin
		// Store the current value of q in the register
		q_reg <= q;
		
		if (shift_ena == 1'b1) begin
			// Shift the data into the shifted_data wire
			shifted_data <= {q_reg[2:0], data};
		end else begin
			// If shift_ena is low, just keep the q value unchanged
			shifted_data <= q;
		end
		
		if (count_ena == 1'b1) begin
			// Decrement the q value
			q <= q_reg - 1'b1;
		end else begin
			// If count_ena is low, just keep the q value unchanged
			q <= q_reg;
		end
	end

endmodule
