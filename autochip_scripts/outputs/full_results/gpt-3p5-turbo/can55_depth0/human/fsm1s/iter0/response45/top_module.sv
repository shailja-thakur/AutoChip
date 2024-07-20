module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk) begin
		if (reset)
			state <= 2'b01; // initial state B
		else
			state <= next_state;
	end
	
	always @(state or in) begin
		case (state)
			2'b00: begin // state A
				if (in)
					next_state = 2'b00; // stay in state A
				else
					next_state = 2'b01; // transition to state B
				out = 1'b0;
			end
			2'b01: begin // state B
				if (in)
					next_state = 2'b01; // stay in state B
				else
					next_state = 2'b00; // transition to state A
				out = 1'b1;
			end
		endcase
	end
endmodule
