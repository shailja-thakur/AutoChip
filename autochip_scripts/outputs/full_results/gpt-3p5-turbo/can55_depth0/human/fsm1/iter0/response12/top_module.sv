module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define state enumeration
	typedef enum logic [1:0] {B, A} State;

	// Define register variables
	reg State current_state, next_state;

	// Define default state
	initial begin
		current_state <= B;
	end

	// Synchronous process for state transition
	always @(posedge clk) begin
		if (areset) begin
			current_state <= B;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state and output logic
	always @(current_state or in) begin
		case (current_state)
			B: begin
				if (in) begin
					next_state = B;
					out = 1;
				end else begin
					next_state = A;
					out = 0;
				end
			end

			A: begin
				if (in) begin
					next_state = A;
					out = 1;
				end else begin
					next_state = B;
					out = 0;
				end
			end
		endcase
	end

endmodule
