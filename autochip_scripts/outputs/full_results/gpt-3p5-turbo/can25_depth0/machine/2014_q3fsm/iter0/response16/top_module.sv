module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, nextState;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 0;
	else
		state <= nextState;
end

always @* begin
	case (state)
		0: begin // A
			if (s)
				nextState = 1; // B
			else
				nextState = state;
		end

		1: begin // B
			if (w)
				nextState = 3; // S11
			else
				nextState = 2; // S10
		end

		2: begin // C
			if (w)
				nextState = 3; // S11
			else
				nextState = 2; // S10
		end

		3: begin // S10
			if (w)
				nextState = 5; // S21
			else
				nextState = 4; // S20
		end

		4: begin // S11
			if (w)
				nextState = 6; // S22
			else
				nextState = 5; // S21
		end

		5: begin // S20
			nextState = 1; // B
		end

		6: begin // S21
			if (w)
				nextState = 2; // C
			else
				nextState = 1; // B
		end

		7: begin // S22
			if (w)
				nextState = 1; // B
			else
				nextState = 2; // C
		end
	endcase
end

always @(posedge clk) begin

	// State outputs
	case (state)
		0: z <= 0; // A
		1: z <= 0; // B
		2: z <= 0; // C
		3: z <= 0; // S10
		4: z <= 0; // S11
		5: z <= 0; // S20
		6: z <= 0; // S21
		7: z <= 0; // S22
	endcase
end

endmodule
