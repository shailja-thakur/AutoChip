module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	typedef enum logic [1:0] {S_A, S_B} state_type;
	reg state_type current_state, next_state;
	
	// Define outputs
	wire out_reg;
	assign out = out_reg;
	
	// Combinational logic
	always_comb begin
		case(current_state)
			S_B: out_reg = 1'b1;
			S_A: out_reg = 1'b0;
			default: out_reg = 1'b0;
		endcase
	end
	
	// Sequential logic
	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			current_state <= S_B;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		case(current_state)
			S_B:
				if (in) begin
					next_state = S_B;
				end else begin
					next_state = S_A;
				end
			S_A:
				if (in) begin
					next_state = S_A;
				end else begin
					next_state = S_B;
				end
			default:
				next_state = S_B;
		endcase
	end
endmodule
