module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// Define states using localparam
	localparam S = 3'b000;
	localparam S1 = 3'b001;
	localparam S11 = 3'b010;
	localparam S110 = 3'b011;
	localparam Done = 3'b100;

	reg [2:0] state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case(state)
			S: begin
				if (data)
					next_state = S1;
				else
					next_state = S;
			end

			S1: begin
				if (data)
					next_state = S11;
				else
					next_state = S;
			end

			S11: begin
				if (data)
					next_state = S11;
				else
					next_state = S110;
			end

			S110: begin
				if (data)
					next_state = Done;
				else
					next_state = S;
			end

			Done: begin
				next_state = Done;
			end

			default: begin
				next_state = S; // Default to state S if something goes wrong
			end
		endcase
	end

	// State flip-flops (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S;
		else
			state <= next_state;
	end

	// Output logic based on current state
	always @(*) begin
		if (state == Done)
			start_shifting = 1;
		else
			start_shifting = 0;
		end
endmodule
