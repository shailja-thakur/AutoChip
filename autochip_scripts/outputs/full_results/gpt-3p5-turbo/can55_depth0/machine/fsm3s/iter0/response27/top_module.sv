module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	// Declare state and next_state variables
	logic [1:0] state;
	logic [1:0] next_state;

	// State register
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			default: next_state = A;
		endcase
	end

	// Output logic
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
