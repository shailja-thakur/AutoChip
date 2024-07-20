module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define the states of the FSM
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} fsm_state;

	// Declare the current state signal
	reg [1:0] current_state;

	// Declare the next state signal
	reg [1:0] next_state;

	// Initialize current state to A
	initial begin
		current_state <= A;
	end

	// Define the state transition logic
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Define the next state logic
	always @(current_state, w) begin
		case (current_state)
			A: begin
				if (s == 1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w == 1) begin
					next_state = C;
				end else begin
					next_state = B;
				end
			end
			C: begin
				if (w == 1) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			D: begin
				if (w == 1) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
		endcase
	end

	// Define the output logic
	always @(current_state) begin
		case (current_state)
			A, B, C: begin
				z <= 0;
			end
			D: begin
				z <= 1;
			end
		endcase
	end

endmodule
