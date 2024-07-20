module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	// States
	typedef enum logic [1:0] {
		A,      // Initial state
		B,      // State B where checking w for 3 cycles happens
	} state_t;
	
	state_t state, next_state;
	reg [1:0] w_count;    // Stores number of times w was 1 in 3 cycles
	reg [1:0] cycle_count; // To count the three clock cycles in state B

	// State transition
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= A;
			w_count <= 2'b00;
			cycle_count <= 2'b00;
			z <= 1'b0;
		end else begin
			state <= next_state;
			
			if (state == A) begin
				w_count <= 2'b00;
				cycle_count <= 2'b00;
				z <= 1'b0;
			end else if (state == B) begin
				cycle_count <= cycle_count + 1'b1;
				if (w) begin
					w_count <= w_count + 1'd1;
				end
				
				if (cycle_count == 2'b10) begin
					if (w_count == 2'b10) begin
						z <= 1'b1;                        
					end else begin
						z <= 1'b0;
					end
					w_count <= 2'b00; // Resetting count for the next 3 cycles
					cycle_count <= 2'b00; // Resetting cycle count to start new count
				end
			end
		end
	end

	// Next state logic
	always_comb begin
		case(state)
			A: begin
				if (s) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end

			B: begin
				next_state = B; // Remain in B to cause continuous checking
			end
		endcase
	end

endmodule
