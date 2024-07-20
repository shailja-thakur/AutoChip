module top_module (input clk, input in, input reset, output out);

	reg [1:0] state, next_state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // reset state to A
		else
			state <= next_state;
	end
	
	always @(state, in) begin
		case (state)
			2'b00: begin
				if (in)
					next_state = 2'b01; // transition to state B
				else
					next_state = 2'b00; // transition to state A
			end
			
			2'b01: begin
				if (in)
					next_state = 2'b01; // stay in state B
				else
					next_state = 2'b10; // transition to state C
			end
			
			2'b10: begin
				if (in)
					next_state = 2'b01; // transition to state A
				else
					next_state = 2'b11; // transition to state D
			end
			
			2'b11: begin
				if (in)
					next_state = 2'b10; // transition to state C
				else
					next_state = 2'b01; // transition to state B
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			2'b00: out = 1'b0; // output 0 in state A
			2'b01: out = 1'b0; // output 0 in state B
			2'b10: out = 1'b0; // output 0 in state C
			2'b11: out = 1'b1; // output 1 in state D
		endcase
	end
	
endmodule
