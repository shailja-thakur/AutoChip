module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {
		B = 2'b00,
		A = 2'b01
	} state_t;
	
	state_t current_state, next_state;
	
	// State transition logic
	always @(*) begin
		case (current_state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			default: next_state = B;
		endcase
	end
	
	// Output logic
	always @(*) begin
		case (current_state)
			B: out = 1;
			A: out = 0;
			default: out = 1;
		endcase
	end
	
	// State register logic
	always @(posedge clk) begin
		if (reset)
			current_state <= B;
		else
			current_state <= next_state;
	end

endmodule
