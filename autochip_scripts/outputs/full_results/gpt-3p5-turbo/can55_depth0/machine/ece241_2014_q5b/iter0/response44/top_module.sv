module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	// Define the two states of the state machine
	parameter A = 0;
	parameter B = 1;

	// Register to store the current state of the state machine
	reg [1:0] state;

	// Assign initial value to state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= state;
	end

	// Assign output z based on the state and input x
	assign z = (state == A && x) || (state == B && !x);

	// State transition logic
	always @(posedge clk) begin
		case (state)
			A: begin
				if (x)
					state <= B;
				else
					state <= A;
			end
			B: begin
				state <= B;
			end
			default: begin
				state <= A;
			end
		endcase
	end

endmodule
