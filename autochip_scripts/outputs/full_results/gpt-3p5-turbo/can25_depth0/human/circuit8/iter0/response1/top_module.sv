module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_reg;
reg q_reg;

always @(posedge clock) begin
	// Use synchronous reset to reset the registers
	if (reset) begin
		p_reg <= 0;
		q_reg <= 0;
	end else begin
		// Use a case statement to implement the sequential circuit
		case ({p_reg, q_reg, a})
			3'b000: begin
				p_reg <= 0;
				q_reg <= 0;
			end
			3'b001: begin
				p_reg <= 1;
				q_reg <= 0;
			end
			3'b010: begin
				p_reg <= 0;
				q_reg <= 1;
			end
			3'b011: begin
				p_reg <= 1;
				q_reg <= 1;
			end
			default: begin
				p_reg <= p_reg;
				q_reg <= q_reg;
			end
		endcase
	end
end

assign p = p_reg;
assign q = q_reg;

endmodule
