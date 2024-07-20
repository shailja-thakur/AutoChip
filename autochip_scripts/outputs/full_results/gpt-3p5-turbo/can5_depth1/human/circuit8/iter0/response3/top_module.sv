module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	
	// Registers
	reg p_reg;
	reg q_reg;
	
	// Assigning outputs
	assign p = p_reg;
	assign q = q_reg;
	
	always @(posedge clock) begin
		// State transitions and output assignments
		if (a == 1'b1) begin
			p_reg <= 1'b0;
			q_reg <= 1'b0;
		end else begin
			if (p_reg == 1'b1) begin
				p_reg <= 1'b0;
				q_reg <= 1'b0;
			end else begin
				p_reg <= 1'b1;
				q_reg <= 1'b1;
			end
		end
	end
endmodule
