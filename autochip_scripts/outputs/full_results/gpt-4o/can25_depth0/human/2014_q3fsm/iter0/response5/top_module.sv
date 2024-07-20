module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// State declaration
	typedef enum reg [1:0] {S_A, S_B, S_C, S_D, S_E} state_t;
	state_t state, next_state;
	
	// Counter for 'w' being 1
	reg [1:0] one_count;
	
	// State transition
	always @ (posedge clk) begin
		if (reset) begin
			state <= S_A;
			one_count <= 2'b00;
			z <= 1'b0;
		end
		else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @ (*) begin
		z = 1'b0; // default value
		next_state = state;
		case (state)
			S_A: begin
				if (s == 1'b1) begin
					next_state = S_B;
				end
				else begin
					next_state = S_A;
				end
			end
			
			S_B: begin
				if (one_count == 2'b10) begin
					next_state = S_C;
				end
			end
			
			S_C: begin 
			    next_state = S_D;
			end
			
			S_D: begin
			    next_state = S_E;
			end
			
			S_E: begin
				next_state = S_B; // Reset cycle
			end
		endcase
	end
	
	// Output and counter logic
	always @ (posedge clk) begin
		if (reset) begin
			one_count <= 2'b00;
			z <= 1'b0;
		end
		else if (state == S_B || state == S_C || state == S_D) begin
			if (w == 1'b1) begin
				one_count <= one_count + 1'b1;
			end
			if (state == S_D && one_count == 2'b01 && w == 1'b1) begin
				z <= 1'b1;
			end
			else begin
				z <= 1'b0;
			end
		end
		else if (state == S_E) begin
			one_count <= 2'b00;
		end
	end

endmodule
