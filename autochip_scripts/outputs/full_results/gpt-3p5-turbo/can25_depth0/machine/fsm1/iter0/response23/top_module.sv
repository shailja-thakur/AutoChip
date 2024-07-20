module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	// Define state constants
	parameter A = 0;
	parameter B = 1;

	// Define state and next state variables
	reg [1:0] state;
	reg [1:0] next_state;

	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// Next state logic
	always @(state or in) begin
		case (state)
			A: begin
				if (in)
					next_state <= A;
				else
					next_state <= B;
			end
			B: begin
				if (in)
					next_state <= B;
				else
					next_state <= A;
			end
			default: next_state <= B;
		endcase
	end

	// Output logic
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
