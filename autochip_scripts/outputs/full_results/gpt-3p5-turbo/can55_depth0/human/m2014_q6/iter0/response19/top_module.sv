module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000;  // reset to state A
	else
		state <= next_state;  // transition to next state
end

always @(state or w) begin
	case (state)
		3'b000:  // state A
			if (w)
				next_state = 3'b000;  // go to state A
			else
				next_state = 3'b001;  // go to state B
		3'b001:  // state B
			if (w)
				next_state = 3'b010;  // go to state C
			else
				next_state = 3'b011;  // go to state D
		3'b010:  // state C
			if (w)
				next_state = 3'b010;  // go to state C
			else
				next_state = 3'b011;  // go to state D
		3'b011:  // state D
			if (w)
				next_state = 3'b100;  // go to state F
			else
				next_state = 3'b000;  // go to state A
		3'b100:  // state E
			if (w)
				next_state = 3'b100;  // go to state E
			else
				next_state = 3'b011;  // go to state D
		3'b101:  // state F
			if (w)
				next_state = 3'b010;  // go to state C
			else
				next_state = 3'b011;  // go to state D
	endcase
end

assign z = (state == 3'b100);  // output z is high when in state E

endmodule
