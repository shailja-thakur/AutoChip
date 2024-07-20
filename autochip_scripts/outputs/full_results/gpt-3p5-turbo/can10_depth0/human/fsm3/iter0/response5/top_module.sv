module top_module (
	input clk,
	input in,
	input areset,
	output out
);
 
	reg [1:0] state, next_state;
	reg output_reg;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // reset to state A
		else
			state <= next_state;
	end
	
	always @* begin
		case (state)
			2'b00: begin // state A
				if (in)
					next_state = 2'b01; // next state is B
				else
					next_state = 2'b00; // next state is A
				output_reg = 1'b0; // output is 0
			end
			2'b01: begin // state B
				if (in)
					next_state = 2'b01; // next state is B
				else
					next_state = 2'b10; // next state is C
				output_reg = 1'b0; // output is 0
			end
			2'b10: begin // state C
				if (in)
					next_state = 2'b11; // next state is D
				else
					next_state = 2'b00; // next state is A
				output_reg = 1'b0; // output is 0
			end
			2'b11: begin // state D
				if (in)
					next_state = 2'b10; // next state is C
				else
					next_state = 2'b01; // next state is B
				output_reg = 1'b1; // output is 1
			end
		endcase
	end
	
	always @(posedge clk) begin
		out <= output_reg;
	end
	
endmodule
