module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);


reg [2:0] state, next_state;


always @(posedge clk, posedge reset) begin
	if (reset)
		state <= 3'b000;
	else
		state <= next_state;
end


always @(state, w) begin
	case(state)
		3'b000: begin // state A
			if (w)
				next_state = 3'b000; // stay in state A
			else
				next_state = 3'b001; // go to state B
		end
		3'b001: begin // state B
			if (w)
				next_state = 3'b011; // go to state D
			else
				next_state = 3'b010; // go to state C
		end
		3'b010: begin // state C
			if (w)
				next_state = 3'b011; // go to state D
			else
				next_state = 3'b100; // go to state E
		end
		3'b011: begin // state D
			if (w)
				next_state = 3'b001; // go to state B
			else
				next_state = 3'b101; // go to state F
		end
		3'b100: begin // state E
			if (w)
				next_state = 3'b011; // go to state D
			else
				next_state = 3'b100; // stay in state E
		end
		3'b101: begin // state F
			if (w)
				next_state = 3'b001; // go to state B
			else
				next_state = 3'b010; // go to state C
		end
	endcase
end


always @(state, next_state) begin
	case(state)
		3'b000: z = 1'b0; // output is 0 in state A
		3'b001: z = 1'b0; // output is 0 in state B
		3'b010: z = 1'b0; // output is 0 in state C
		3'b011: z = 1'b0; // output is 0 in state D
		3'b100: z = 1'b1; // output is 1 in state E
		3'b101: z = 1'b1; // output is 1 in state F
	endcase
end

endmodule
