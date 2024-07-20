module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state, next_state;
reg out;

always @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= 2'b10;
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		2'b10: begin // state B
			if (in) begin
				next_state = 2'b10; // Stay in state B
			end else begin
				next_state = 2'b01; // Transition to state A
			end
			out = 1;
		end
		2'b01: begin // state A
			if (in) begin
				next_state = 2'b01; // Stay in state A
			end else begin
				next_state = 2'b10; // Transition to state B
			end
			out = 0;
		end
		default: begin
			next_state = 2'b10;
			out = 1;
		end
	endcase
end

endmodule
