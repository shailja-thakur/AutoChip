module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define states
	typedef enum {A, B, C, D} state_t;
	
	// Define current state and next state
	reg [1:0] curr_state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			curr_state <= A;
			out <= 0;
		end else begin
			curr_state <= next_state;
			case (curr_state)
				A: begin
					if (in) begin
						next_state = B;
					end else begin
						next_state = A;
					end
					out <= 0;
				end
				B: begin
					if (in) begin
						next_state = C;
					end else begin
						next_state = B;
					end
					out <= 0;
				end
				C: begin
					if (in) begin
						next_state = D;
					end else begin
						next_state = A;
					end
					out <= 0;
				end
				D: begin
					if (in) begin
						next_state = B;
					end else begin
						next_state = C;
					end
					out <= 1;
				end
				default: next_state = A;
			endcase
		end
	end
endmodule
