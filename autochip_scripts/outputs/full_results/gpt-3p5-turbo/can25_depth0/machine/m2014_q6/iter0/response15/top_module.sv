module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, nextState;

always @(posedge clk) begin
	if (reset)
		state <= 3'b000;
	else
		state <= nextState;
end

always @(state or w) begin
	case (state)
		3'b000: begin // state A
			if (w)
				nextState <= 3'b000; // stay in state A
			else
				nextState <= 3'b001; // transition to state B
		end
		3'b001: begin // state B
			if (w)
				nextState <= 3'b010; // transition to state D
			else
				nextState <= 3'b011; // transition to state C
		end
		3'b010: begin // state C
			if (w)
				nextState <= 3'b010; // stay in state C
			else
				nextState <= 3'b100; // transition to state E
		end
		3'b011: begin // state D
			if (w)
				nextState <= 3'b000; // transition to state A
			else
				nextState <= 3'b101; // transition to state F
		end
		3'b100: begin // state E
			if (w)
				nextState <= 3'b010; // transition to state D
			else
				nextState <= 3'b100; // stay in state E
		end
		3'b101: begin // state F
			if (w)
				nextState <= 3'b011; // transition to state C
			else
				nextState <= 3'b101; // stay in state F
		end
		default: nextState <= 3'b000; // default to state A
	endcase
end

assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

endmodule
