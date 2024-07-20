module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State enumeration
	typedef enum logic[1:0] {
		S,
		S1,
		S10
	} state_t;

	reg state, next_state;
	
	// Default initial state
	initial begin
		state <= S;
	end
	
	// Sequential logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always_comb begin
		case (state)
			S:
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			S1:
				if (x == 1'b0) begin
					next_state = S10;
				end else begin
					next_state = S1;
				end
			S10:
				if (x == 1'b0) begin
					next_state = S;
				end else begin
					next_state = S1;
				end
			default:
				next_state = S;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (state)
			S, S1:
				z = 1'b0;
			S10:
				z = x;
			default:
				z = 1'b0;
		endcase
	end
	
endmodule
