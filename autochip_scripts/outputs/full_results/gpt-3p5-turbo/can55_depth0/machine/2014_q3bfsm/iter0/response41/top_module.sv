module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else 
			state <= next_state;
	end

	always @* begin
		case(state)
			3'b000: begin // State A
				if (x)
					next_state = 3'b001; // Transition to state B
				else
					next_state = 3'b000; // Remain in state A
			end
			
			3'b001: begin // State B
				if (x)
					next_state = 3'b100; // Transition to state E
				else
					next_state = 3'b001; // Remain in state B
			end
			
			3'b010: begin // State C
				if (x)
					next_state = 3'b001; // Transition to state B
				else
					next_state = 3'b010; // Remain in state C
			end
			
			3'b011: begin // State D
				if (x)
					next_state = 3'b010; // Transition to state C
				else
					next_state = 3'b001; // Transition to state B
			end
			
			3'b100: begin // State E
				if (x)
					next_state = 3'b100; // Remain in state E
				else
					next_state = 3'b011; // Transition to state D
			end
			
			default: next_state = 3'b000; // Default state is A
		endcase
	end
	
	always @(state) begin
		if (state == 3'b100 || state == 3'b101)
			z = 1;
		else
			z = 0;
	end

endmodule
