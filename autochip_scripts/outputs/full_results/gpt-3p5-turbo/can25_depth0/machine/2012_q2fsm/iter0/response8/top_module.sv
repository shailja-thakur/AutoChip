module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // initial state is A
	else begin
		case (state)
			3'b000: // state A
				if (w)
					state <= 3'b001; // transition to state B
				else
					state <= 3'b000; // stay in state A
			3'b001: // state B
				if (w)
					state <= 3'b010; // transition to state C
				else
					state <= 3'b100; // transition to state D
			3'b010: // state C
				if (w)
					state <= 3'b101; // transition to state E
				else
					state <= 3'b100; // transition to state D
			3'b011, 3'b101: // states D and E
				if (w)
					state <= state; // stay in current state
				else
					state <= 3'b000; // transition to state A
			3'b100: // state D
				if (w)
					state <= 3'b111; // transition to state F
				else
					state <= 3'b000; // transition to state A
			3'b111: // state F
				if (w)
					state <= 3'b110; // transition to state C
				else
					state <= 3'b100; // transition to state D
			default:
				state <= 3'b000; // default to state A
		endcase
	end
end

assign z = (state == 3'b101) || (state == 3'b111); // set z to 1 when in state E or F

endmodule
