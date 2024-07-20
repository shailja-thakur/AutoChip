module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000; // initial state A
	else begin
		case (state)
			3'b000: // state A
				if (w) state <= 3'b001; // transition to state B
				else state <= 3'b000; // stay in state A
			3'b001: // state B
				if (w) state <= 3'b010; // transition to state C
				else state <= 3'b100; // transition to state D
			3'b010: // state C
				if (w) state <= 3'b101; // transition to state E
				else state <= 3'b100; // transition to state D
			3'b011: // state D
				if (w) state <= 3'b111; // transition to state F
				else state <= 3'b000; // transition to state A
			3'b100: // state E
				if (w) state <= 3'b100; // stay in state E
				else state <= 3'b100; // stay in state E
			3'b101: // state F
				if (w) state <= 3'b010; // transition to state C
				else state <= 3'b100; // transition to state D
			default: state <= 3'b000; // default to state A
		endcase
	end
end

assign z = (state == 3'b100) || (state == 3'b101); // output z is set to 1 when in state E or F

endmodule
