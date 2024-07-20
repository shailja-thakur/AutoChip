module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State declaration
	typedef enum reg [3:0] {
		A = 4'd0,
		B = 4'd1,
		S0 = 4'd2,
		S1 = 4'd3,
		S10 = 4'd4,
		G1 = 4'd5,
		G2 = 4'd6,
		P0 = 4'd7,
		P1 = 4'd8
	} state_type;

	// State registers
	state_type current_state, next_state;

	// State transition logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			A: next_state = B;
			B: next_state = S0;
			S0: next_state = (x) ? S1 : S0;
			S1: next_state = (x) ? S1 : S10;
			S10: next_state = (x) ? G1 : S0;
			G1: next_state = (y) ? P1 : G2;
			G2: next_state = (y) ? P1 : P0;
			P0: next_state = P0;
			P1: next_state = P1;
			default: next_state = A;  // default to state A in case of unexpected state
		endcase
	end

	// Output logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
		end else begin
			case (current_state)
				B: f <= 1;
				default: f <= 0;
			endcase
			
			case (current_state)
				G1, G2, P1: g <= 1;
				default: g <= 0;
			endcase
		end
	end

endmodule
