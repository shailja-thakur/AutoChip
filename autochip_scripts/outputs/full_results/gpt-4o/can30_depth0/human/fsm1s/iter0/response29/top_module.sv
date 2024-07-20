module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define state encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			B: if (in) 
					next_state = B;
			   else 
					next_state = A;
			A: if (in) 
					next_state = A;
			   else 
					next_state = B;
			default: next_state = B; // Default state
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1'bx; // Should never happen
		endcase
	end

endmodule
