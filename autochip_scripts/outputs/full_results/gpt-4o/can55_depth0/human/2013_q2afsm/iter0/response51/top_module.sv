module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State Encoding
	typedef enum reg [1:0] {
		S_A = 2'b00,
		S_B = 2'b01,
		S_C = 2'b10,
		S_D = 2'b11
	} state_t;
	
	state_t state, next_state;

	// State Flip-Flops (sequential logic)
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= S_A; // Synchronous reset to state A
		else
			state <= next_state;
	end

	// State Table (combinational logic)
	always @(*) begin
		case (state)
			S_A: begin
				if (r[1])
					next_state = S_B; // Device 1 request has highest priority
				else if (r[2])
					next_state = S_C; // Device 2 request has second priority
				else if (r[3])
					next_state = S_D; // Device 3 request has lowest priority
				else
					next_state = S_A;
			end
			
			S_B: begin
				if (r[1])
					next_state = S_B; // Stay in S_B as long as r1 is 1
				else
					next_state = S_A; // Return to S_A if r1 is 0
			end
			
			S_C: begin
				if (r[2])
					next_state = S_C; // Stay in S_C as long as r2 is 1
				else
					next_state = S_A; // Return to S_A if r2 is 0
			end
			
			S_D: begin
				next_state = S_A; // Always return to S_A from S_D
			end
			
			default: next_state = S_A; // Default to state A
		endcase
	end

	// Output Logic
	always @(*) begin
		case (state)
			S_A: begin
				g = 3'b000;
			end
			
			S_B: begin
				g = 3'b001; // g1 set to 1
			end
			
			S_C: begin
				g = 3'b010; // g2 set to 1
			end
			
			S_D: begin
				g = 3'b000; // Device 3 has no grant output 
			end
			
			default: g = 3'b000; // Default to no grants
		endcase
	end

endmodule
