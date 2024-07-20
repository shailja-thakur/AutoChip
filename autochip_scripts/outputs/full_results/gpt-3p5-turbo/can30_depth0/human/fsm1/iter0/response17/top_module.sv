module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	// Define the state enumeration
	typedef enum logic [1:0] {
		B,
		A
	} state_t;

	// Define the state register and next state
	reg state_t state_reg, next_state_reg;

	// Define the output register
	reg out_reg;

	// Define the output logic
	assign out = out_reg;

	// Define the synchronous always block
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_reg <= B;
			out_reg <= 0;
		end else begin
			state_reg <= next_state_reg;
			out_reg <= (state_reg == A);
		end
	end

	// Define the combinational always block for the next state logic
	always @* begin
		case (state_reg)
			B: begin
				case (in)
					0: next_state_reg = A;
					1: next_state_reg = B;
					default: next_state_reg = B;
				endcase
			end
			A: begin
				case (in)
					0: next_state_reg = B;
					1: next_state_reg = A;
					default: next_state_reg = A;
				endcase
			end
			default: next_state_reg = B;
		endcase
	end

endmodule
