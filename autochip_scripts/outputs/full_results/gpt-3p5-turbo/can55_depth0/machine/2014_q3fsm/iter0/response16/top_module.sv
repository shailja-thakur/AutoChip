module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	// State enum definition
	typedef enum logic [2:0] {
		A,
		B,
		C,
		S10,
		S11,
		S20,
		S21,
		S22
	} state_t;

	reg [2:0] current_state, next_state;

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	always_comb begin
		case (current_state)
			A:
				next_state = s ? B : current_state;
			B:
				next_state = w ? S11 : S10;
			C:
				next_state = w ? S11 : S10;
			S10:
				next_state = w ? S21 : S20;
			S11:
				next_state = w ? S22 : S21;
			S20:
				next_state = B;
			S21:
				next_state = w ? C : B;
			S22:
				next_state = w ? B : C;
		endcase
	end

	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			z <= 0;
		end else begin
			case (current_state)
				S20: z <= 1;
				B, C, S10, S11, S21, S22: z <= 0;
				default: z <= z;
			endcase
		end
	end
endmodule
