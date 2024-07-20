module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk) begin
	if (areset) begin
		state <= 1'b0; // reset to state B
	end else begin
		state <= next_state; // update state
	end
end

always @(state, in) begin
	case(state)
		0: begin // state A
			if (in) begin
				next_state <= 1'b0; // next state is A
			end else begin
				next_state <= 1'b1; // next state is B
			end
		end
		1: begin // state B
			if (in) begin
				next_state <= 1'b1; // next state is B
			end else begin
				next_state <= 1'b0; // next state is A
			end
		end
	endcase
end

assign out = (state == 1'b1) ? 1'b1 : 1'b0; // set output high when state is B, low otherwise

endmodule
