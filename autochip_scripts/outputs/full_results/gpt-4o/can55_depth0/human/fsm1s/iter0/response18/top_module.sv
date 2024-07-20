module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State declaration
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always_comb begin
		case (state)
			B: begin
				out = 1;
				if (in == 1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			
			A: begin
				out = 0;
				if (in == 1) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			
			default: begin
				next_state = B;
				out = 1;
			end
		endcase
	end

endmodule
