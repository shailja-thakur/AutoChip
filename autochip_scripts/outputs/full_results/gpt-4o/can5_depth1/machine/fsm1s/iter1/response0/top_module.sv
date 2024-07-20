module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define states
	typedef enum logic [1:0] {
		A = 1'b0, 
		B = 1'b1
	} state_t;

	// State register
	state_t state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: begin
				next_state = in ? A : B;
			end	
			B: begin
				next_state = in ? B : A;
			end
			default: next_state = A; // Default state if undefined state occurs
		endcase
	end

	// Sequential block triggered on rising edge of clk
	always @(posedge clk) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state;
	end

	// Output assignment
	always @(posedge clk) begin
		out <= (state == B);
	end

endmodule
