module top_module (
	input wire clk,
	input wire reset,
	input wire w,
	output wire z
);

	// State enumeration
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_type;

	// Registers for state and next_state
	reg state_type current_state;
	reg state_type next_state;
	// D Flip-Flop for z output
	reg z_reg;

	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			current_state <= A;
			z_reg <= 0;
		end else begin
			current_state <= next_state;
			z_reg <= (next_state == E || next_state == F) ? 1 : 0;
		end
	end

	// Next state logic
	always @(current_state, w) begin
		case(current_state)
			A: next_state = (w == 1'b0) ? B : A;
			B: next_state = (w == 1'b1) ? D : C;
			C: next_state = (w == 1'b1) ? D : E;
			D: next_state = (w == 1'b1) ? A : F;
			E: next_state = (w == 1'b1) ? D : E;
			F: next_state = (w == 1'b1) ? D : C;
			default: next_state = A;
		endcase
	end

	// Assign output
	assign z = z_reg;
endmodule
