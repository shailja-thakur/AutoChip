module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		A = 2'b00,  // Reset state
		B = 2'b01,  // Check w for 3 cycles
		C = 2'b10   // Output z based on condition
	} state_t;
	
	state_t state, next_state;
	reg [1:0] w_count;  // Count the number of times w = 1 in 3 cycles
	reg [1:0] cycle_count;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		next_state = state;
		case (state)
			A: begin
				if (s) next_state = B;
			end
			B: begin
				if (cycle_count == 3) next_state = C;
			end
			C: begin
				next_state = B;  // Go back to B to start checking w again
			end
		endcase
	end

	// Output and internal signals logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 0;
			w_count <= 0;
			cycle_count <= 0;
		end else begin
			case (state)
				A: begin
					z <= 0;
				end
				B: begin
					if (cycle_count < 3) begin
						cycle_count <= cycle_count + 1;
						if (w) w_count <= w_count + 1;
					end else begin
						cycle_count <= 0;  // Reset the cycle count
					end
				end
				C: begin
					z <= (w_count == 2);  // Set z based on the w_count
					w_count <= 0;  // Reset w_count for next round of checking
				end
			endcase
		end
	end
endmodule
