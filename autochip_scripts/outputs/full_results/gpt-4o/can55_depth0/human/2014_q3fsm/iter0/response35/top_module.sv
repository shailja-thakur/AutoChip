module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C1 = 2'b10,
		C2 = 2'b11
	} state_t;
	
	state_t state, next_state;
	reg [1:0] w_count; // Counter for w=1 in B state
	reg [1:0] cycle_count; // Counter for clock cycles in B state

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			w_count <= 0;
			cycle_count <= 0;
			z <= 0;
		end
		else begin
			state <= next_state;
		end
	end

	// Next state logic and outputs
	always @(*) begin
		next_state = state;
		z = 0;
		case (state)
			A: begin
				if (s == 1) begin
					next_state = B;
				end
			end
			
			B: begin
				if (cycle_count == 3) begin
					next_state = A;
					if (w_count == 2) begin
						z = 1;
					end
				end
				else begin
					next_state = B;
				end
			end
			
		endcase
	end

	// Count logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			w_count <= 0;
			cycle_count <= 0;
		end
		else if (state == B) begin
			cycle_count <= cycle_count + 1;
			if (w == 1) begin
				w_count <= w_count + 1;
			end
			if (cycle_count == 3) begin
				w_count <= 0;
				cycle_count <= 0;
			end
		end
	end

endmodule
