module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b00;  // state A
		else
			state <= next_state;
	end
	
	always @(*)
	begin
		case (state)
			2'b00:  // state A
				begin
					if (in)
						next_state = 2'b10;  // state B
					else
						next_state = 2'b00;  // stay in state A
					out_reg = 1'b0;
				end
				
			2'b01:  // state B
				begin
					if (in)
						next_state = 2'b10;  // state B
					else
						next_state = 2'b01;  // stay in state B
					out_reg = 1'b0;
				end
				
			2'b10:  // state C
				begin
					if (in)
						next_state = 2'b11;  // state D
					else
						next_state = 2'b00;  // state A
					out_reg = 1'b0;
				end
				
			2'b11:  // state D
				begin
					if (in)
						next_state = 2'b10;  // state B
					else
						next_state = 2'b10;  // stay in state D
					out_reg = 1'b1;
				end
		endcase
	end
	
	always @(posedge clk)
	begin
		out <= out_reg;
	end
	
endmodule
