module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare the state register
	reg [2:0] state;

	// Declare the next state register
	reg [2:0] next_state;

	// Declare the output register
	reg z;

	// Assign next state based on current state and input
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else
			state <= next_state;
	end

	// Assign output based on current state
	always @(state, w) begin
		case (state)
			3'b000: begin
				if (w)
					next_state <= 3'b000; // A (0) --1--> A
				else
					next_state <= 3'b001; // A (0) --0--> B
			end
			3'b001: begin
				if (w)
					next_state <= 3'b100; // B (0) --1--> D
				else
					next_state <= 3'b010; // B (0) --0--> C
			end
			3'b010: begin
				if (w)
					next_state <= 3'b011; // C (0) --1--> D
				else
					next_state <= 3'b100; // C (0) --0--> E
			end
			3'b011: begin
				if (w)
					next_state <= 3'b000; // D (0) --1--> A
				else
					next_state <= 3'b101; // D (0) --0--> F
			end
			3'b100: begin
				if (w)
					next_state <= 3'b011; // E (1) --1--> D
				else
					next_state <= 3'b100; // E (1) --0--> E
			end
			3'b101: begin
				if (w)
					next_state <= 3'b010; // F (1) --1--> D
				else
					next_state <= 3'b010; // F (1) --0--> C
			end
			default: next_state <= 3'b000;
		endcase
	end

	// Assign output based on current state
	always @(state) begin
		case (state)
			3'b100: z <= 1'b1; // Output is 1 in state F
			default: z <= 1'b0; // Output is 0 in all other states
		endcase
	end

endmodule
