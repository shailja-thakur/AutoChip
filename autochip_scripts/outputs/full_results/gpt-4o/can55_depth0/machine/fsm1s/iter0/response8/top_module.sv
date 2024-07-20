module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0;
	parameter B = 1'b1;
    
	reg state;      // Register to hold the current state
	reg next_state; // Register to hold the next state

	// Combinational logic for determining next state
	always @(*) begin
		case (state)
			A: begin
				if (in) 
					next_state = A;
				else 
					next_state = B;
			end
			B: begin
				if (in) 
					next_state = B;
				else 
					next_state = A;
			end
		endcase
	end

	// Sequential logic for state transition
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= B;
		else 
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 1'b1;
		else
			out <= (state == B);
	end

endmodule
