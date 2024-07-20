module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state, next_state;
	
	always @(posedge clk) begin
		if (reset)
			state <= 3'b000; // reset to state A
		else
			state <= next_state;
	end
	
	always @(state, w) begin
		case (state)
			3'b000: begin // state A
				if (w)
					next_state = 3'b000; // stay in state A
				else
					next_state = 3'b001; // transition to state B
			end
			3'b001: begin // state B
				if (w)
					next_state = 3'b011; // transition to state D
				else
					next_state = 3'b010; // transition to state C
			end
			3'b010: begin // state C
				if (w)
					next_state = 3'b011; // transition to state D
				else
					next_state = 3'b100; // transition to state E
			end
			3'b011: begin // state D
				if (w)
					next_state = 3'b000; // transition to state A
				else
					next_state = 3'b101; // transition to state F
			end
			3'b100: begin // state E
				if (w)
					next_state = 3'b011; // transition to state D
				else
					next_state = 3'b100; // stay in state E
			end
			3'b101: begin // state F
				if (w)
					next_state = 3'b011; // transition to state D
				else
					next_state = 3'b010; // transition to state C
			end
		endcase
	end
	
	assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;
	
endmodule
