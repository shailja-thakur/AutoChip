module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {A = 2'b00, B = 2'b01} state_t;
	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			B: begin
				if (in) 
					next_state = B;
				else
					next_state = A;
				out = 1'b1;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 1'b0;
			end
			default: begin
				next_state = B;
				out = 1'b1;
			end
		endcase
	end

	// State register
	always @(posedge clk) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

endmodule
