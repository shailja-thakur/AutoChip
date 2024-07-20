module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	// State encoding
	localparam A = 3'b000,
	           B = 3'b001,
	           C = 3'b010,
	           D = 3'b011,
	           E = 3'b100;

	// State transition
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @ (*) begin
		case (state)
			A: 
				if (x) next_state = B;
				else next_state = A;
			B: 
				if (x) next_state = E;
				else next_state = B;
			C: 
				if (x) next_state = B;
				else next_state = C;
			D: 
				if (x) next_state = C;
				else next_state = B;
			E: 
				if (x) next_state = E;
				else next_state = D;
			default: next_state = A; // should not happen
		endcase
	end

	// Output logic
	always @ (posedge clk or posedge reset) begin
		if (reset)
			z <= 1'b0;
		else
			z <= (state == D) || (state == E);
	end

endmodule
