module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states using enum
	typedef enum logic [3:0] {
		A, B, S0, S1, S10, G1, G2, P0, P1
	} state_t;

	// Define state and next_state variables
	reg state_t state, next_state;
	reg next_f, next_g;

	// Define combinational outputs
	assign f = next_f;
	assign g = next_g;

	// Define state transition and output assignment logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
			next_f <= 0;
			next_g <= 0;
		end else begin
			state <= next_state;
			next_f <= (state == B) ? 1'b1 : 1'b0;
			next_g <= (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;
		end
	end

	// Define next state logic
	always @(*) begin
		case (state)
			A:
				next_state = B;
			B:
				next_state = S0;
			S0:
				next_state = (x == 1'b1) ? S1 : S0;
			S1:
				next_state = (x == 1'b1) ? S1 : S10;
			S10:
				next_state = (x == 1'b1) ? G1 : S0;
			G1:
				next_state = (y == 1'b1) ? P1 : G2;
			G2:
				next_state = (y == 1'b1) ? P1 : P0;
			P0:
				next_state = P0;
			P1:
				next_state = P1;
			default:
				next_state = A;
		endcase
	end

endmodule
