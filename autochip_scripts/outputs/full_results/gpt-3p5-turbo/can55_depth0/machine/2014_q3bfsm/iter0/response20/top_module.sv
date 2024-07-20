module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 3'b000; // Initializing state to A
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case(state)
			3'b000: // State A
				if (x)
					next_state = 3'b001; // Next state is B
				else
					next_state = 3'b000; // Next state is A
			3'b001: // State B
				if (x)
					next_state = 3'b100; // Next state is E
				else
					next_state = 3'b001; // Next state is B
			3'b010: // State C
				if (x)
					next_state = 3'b001; // Next state is B
				else
					next_state = 3'b010; // Next state is C
			3'b011: // State D
				if (x)
					next_state = 3'b010; // Next state is C
				else
					next_state = 3'b001; // Next state is B
			3'b100: // State E
				if (x)
					next_state = 3'b100; // Next state is E
				else
					next_state = 3'b011; // Next state is D
			default:
				next_state = 3'b000; // Default state is A
		endcase
	end
	
	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z = 1'b1; // Output is high when state is D or E
		else
			z = 1'b0;
	end
               
endmodule
