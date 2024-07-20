module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		B = 2'b00,
		A = 2'b01
	} state_t;
	
	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			B: begin
				if (in) begin
					next_state = B;
					out = 1;
				end else begin
					next_state = A;
					out = 1;
				end
			end
			
			A: begin
				if (in) begin
					next_state = A;
					out = 0;
				end else begin
					next_state = B;
					out = 0;
				end
			end
			
			default: begin
				next_state = B; // Default to state B if something goes wrong (shouldn't happen)
				out = 1;
			end
		endcase
	end
	
	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end
	
endmodule
