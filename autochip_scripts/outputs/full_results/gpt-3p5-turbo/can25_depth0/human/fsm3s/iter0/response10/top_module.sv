module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	// Define the signals
	reg [1:0] current_state, next_state;

	// Define the outputs
	assign out = (current_state == D) ? 1'b1 : 1'b0;

	// State transition and output logic
	always @(posedge clk) begin
		if (reset) begin  // Synchronous active high reset
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	always @* begin
		case (current_state)
			A: begin
				if (in) next_state = B;
				else next_state = A;
			end
			B: begin
				if (in) next_state = B;
				else next_state = C;
			end
			C: begin
				if (in) next_state = D;
				else next_state = A;
			end
			D: begin
				if (in) next_state = B;
				else next_state = C;
			end
		endcase
	end

endmodule
