module fsm_module (
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

	// Define state and next_state registers
	reg state_t state, next_state;

	// Assign initial state
	initial begin
		state = A;
	end

	// Compute next state and output
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Update next_state based on current state and inputs
	always @* begin
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
			default: begin
				next_state = A;
			end
		endcase
	end

	// Set output based on current state
	always @* begin
		if (state == D) begin
			out = 1;
		end else begin
			out = 0;
		end
	end

endmodule
module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	fsm_module fsm (
		.clk(clk),
		.in(in),
		.reset(reset),
		.out(out)
	);

endmodule
