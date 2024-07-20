module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state identifiers
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;
 
	state_t state, next_state;
 
	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: begin
				if (in) begin
					next_state = A;
					out = 0;
				end else begin
					next_state = B;
					out = 0;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
					out = 1;
				end else begin
					next_state = A;
					out = 1;
				end
			end
			default: begin
				next_state = B;
				out = 1;
			end
		endcase
	end
 
	// State flip-flops with asynchronous reset (sequential)
	always @(posedge clk, posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end
 
endmodule
