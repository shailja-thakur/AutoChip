module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define state enumeration
	typedef enum logic [1:0] {
		A, B, C, D
	} state_t;
	
	// Define state and next_state registers
	reg state_t state_reg, next_state_reg;
	
	// Define output register
	reg out_reg;
	
	// Synchronous process for next_state logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			next_state_reg <= A;
		end else begin
			case (state_reg)
				A: begin
					if (in)
						next_state_reg <= B;
					else
						next_state_reg <= A;
				end
				
				B: begin
					if (in)
						next_state_reg <= B;
					else
						next_state_reg <= C;
				end
				
				C: begin
					if (in)
						next_state_reg <= D;
					else
						next_state_reg <= A;
				end
				
				D: begin
					if (in)
						next_state_reg <= B;
					else
						next_state_reg <= C;
				end
				
				default: next_state_reg <= A;
			endcase
		end
	end
	
	// Combinational process for output logic
	always @(state_reg) begin
		case (state_reg)
			A: out_reg = 0;
			B: out_reg = 0;
			C: out_reg = 0;
			D: out_reg = 1;
		endcase
	end
	
	// Update state and output registers
	always @(posedge clk) begin
		if (areset)
			state_reg <= A;
		else
			state_reg <= next_state_reg;
			
		out <= out_reg;
	end
endmodule
