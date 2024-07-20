module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Define current and next state
	reg [1:0] state, next_state;

	// Define output
	reg out;

	// Combinational logic for next_state calculation
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			next_state <= A;
		else
		begin
			case (state)
				A: if (in) next_state <= B; else next_state <= A;
				B: if (in) next_state <= B; else next_state <= C;
				C: if (in) next_state <= D; else next_state <= A;
				D: if (in) next_state <= B; else next_state <= C;
				default: next_state <= A;
			endcase
		end
	end

	// Sequential logic for state and output update
	always @(posedge clk or posedge areset)
	begin
		if (areset)
		begin
			state <= A;
			out <= 0;
		end
		else
		begin
			state <= next_state;

			// Update output based on current state
			case (state)
				D: out <= 1;
				default: out <= 0;
			endcase
		end
	end

endmodule
