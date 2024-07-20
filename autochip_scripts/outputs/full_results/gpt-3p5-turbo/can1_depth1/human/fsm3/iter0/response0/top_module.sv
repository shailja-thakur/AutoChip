module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define the states
	typedef enum {A, B, C, D} state_type;
	reg [1:0] state, next_state;
	
	// Define the state transition table
	initial begin
		state = A;
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, in) begin
		case (state)
			A: begin
				if (in == 0) begin
					next_state = A;
					out = 0;
				end else begin
					next_state = B;
					out = 0;
				end
			end
			B: begin
				if (in == 0) begin
					next_state = C;
					out = 0;
				end else begin
					next_state = B;
					out = 0;
				end
			end
			C: begin
				if (in == 0) begin
					next_state = A;
					out = 0;
				end else begin
					next_state = D;
					out = 0;
				end
			end
			D: begin
				if (in == 0) begin
					next_state = C;
					out = 1;
				end else begin
					next_state = B;
					out = 0;
				end
			end
		endcase
	end

endmodule
