module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	
	// register for p output
	reg p_reg;
	
	// register for q output
	reg q_reg;
	
	always @(posedge clock) begin
		// state machine
		case ({p_reg, q_reg})
			2'b00: begin
				if (a) begin
					p_reg <= 1;
					q_reg <= 0;
				end
			end
			2'b01: begin
				if (a) begin
					p_reg <= 1;
					q_reg <= 1;
				end else begin
					p_reg <= 0;
					q_reg <= 0;
				end
			end
			2'b10: begin
				if (a) begin
					p_reg <= 0;
					q_reg <= 0;
				end else begin
					p_reg <= 1;
					q_reg <= 1;
				end
			end
			2'b11: begin
				if (a) begin
					p_reg <= 1;
					q_reg <= 1;
				end
			end
			default: begin
				p_reg <= 0;
				q_reg <= 0;
			end
		endcase
	end
	
	// assign the outputs to the registered outputs
	assign p = p_reg;
	assign q = q_reg;
	
endmodule
