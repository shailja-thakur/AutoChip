module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State encoding
	typedef enum reg [1:0] {
		S_A = 2'b00,
		S_B = 2'b01,
		S_C = 2'b10,
		S_D = 2'b11
	} state_t;
	
	state_t present_state, next_state;
	
	// State flip-flops
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			present_state <= S_A;
		end else begin
			present_state <= next_state;
		end
	end
	
	// Next state logic
	always @(*) begin
		case (present_state)
			S_A: begin
				if (r[1])
					next_state = S_B;
				else if (r[2])
					next_state = S_C;
				else if (r[3])
					next_state = S_D;
				else
					next_state = S_A;
			end
			
			S_B: begin
				if (r[1])
					next_state = S_B;
				else
					next_state = S_A;
			end
			
			S_C: begin
				if (r[2])
					next_state = S_C;
				else
					next_state = S_A;
			end
			
			S_D: begin
				next_state = S_A;
			end
			
			default: next_state = S_A;
		endcase
	end
	
	// Output logic
	always @(*) begin
		g = 3'b000; // Default to no grants
		case (present_state)
			S_A: begin
				// No grants in state A
			end
			S_B: begin
				g[1] = 1;
			end
			S_C: begin
				g[2] = 1;
			end
			S_D: begin
				g[3] = 1;
			end
			default: begin
				// No grants by default
			end
		endcase
	end

endmodule
