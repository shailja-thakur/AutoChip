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
	
	// Declare state and next_state registers
	reg state_t state, next_state;
	
	// Declare output register
	reg out_reg;
	
	always @(posedge clk) begin
		// Synchronous active high reset
		if (reset) begin
			state <= A;
			out_reg <= 0;
		end
		else begin
			state <= next_state;
			out_reg <= (state == D) ? 1 : 0;
		end
	end
	
	always @(state, in) begin
		// Default next state and output value
		next_state = state;
		
		case (state)
			A: begin
				next_state = (in) ? B : A;
			end
			B: begin
				next_state = (in) ? B : C;
			end
			C: begin
				next_state = (in) ? D : A;
			end
			D: begin
				next_state = (in) ? B : C;
			end
		endcase
	end
	
	assign out = out_reg; // Assign output value
	
endmodule
