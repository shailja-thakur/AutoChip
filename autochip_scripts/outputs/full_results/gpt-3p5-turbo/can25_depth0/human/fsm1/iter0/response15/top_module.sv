module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
          
	// Define state enumeration
	typedef enum logic [1:0] {
		B,
		A
	} state_t;

	// Define state register
	reg [1:0] state_reg;
	
	// Define next state register
	reg [1:0] next_state_reg;

	// Async reset to state B
	always @(areset) begin
		if (areset) begin
			state_reg <= B;
		end
	end
	
	// Sequential logic
	always @(posedge clk) begin
		if (!areset) begin
			state_reg <= next_state_reg;
		end
	end
	
	// Determine next state based on current state and input
	always @(state_reg or in) begin
		case (state_reg)
			B: begin
				if (in)
					next_state_reg <= B;
				else
					next_state_reg <= A;
				end
			A: begin
				if (in)
					next_state_reg <= A;
				else
					next_state_reg <= B;
				end
		endcase
	end
	
	// Perform actions based on current state
	always @(state_reg) begin
		case (state_reg)
			B: out <= 1;
			A: out <= 0;
		endcase
	end
endmodule
