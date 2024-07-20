module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {A, B, C, D} state_type;
	
	// Define outputs
	logic out_reg;
	
	// Define current and next state variables
	reg state_type current_state;
	reg state_type next_state;
	
	// Synchronous reset to state A
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= A;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	// State transition logic
	always_comb begin
		case (current_state)
			A: begin
				if (in == 0)
					next_state = A;
				else if (in == 1)
					next_state = B;
			end
			B: begin
				if (in == 0)
					next_state = C;
				else if (in == 1)
					next_state = B;
			end
			C: begin
				if (in == 0)
					next_state = A;
				else if (in == 1)
					next_state = D;
			end
			D: begin
				if (in == 0)
					next_state = C;
				else if (in == 1)
					next_state = B;
			end
			default: next_state = A;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (current_state)
			D: out_reg = 1;
			default: out_reg = 0;
		endcase
	end
	
	// Assign output to output register
	assign out = out_reg;
	
endmodule
