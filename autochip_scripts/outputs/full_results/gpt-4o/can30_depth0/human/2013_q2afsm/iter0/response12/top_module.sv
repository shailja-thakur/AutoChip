module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State Declarations
	typedef enum reg [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;
	
	state_t state, next_state;
	
	// State Flip-Flops (Synchronous)
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A; // Reset state
		else
			state <= next_state;
	end
	
	// State Table (Combinational)
	always @(*) begin
		case (state)
			A:	begin
				if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
				else
					next_state = A;
			end
				
			B:	begin
				if (r[1])
					next_state = B;
				else
					next_state = A;
			end
				
			C:	begin
				if (r[2])
					next_state = C;
				else
					next_state = A;
			end
				
			D: next_state = A; // For simplicity, D returns to A as no specification given
				
			default: next_state = A; // Default to ensure safe state transition
		endcase
	end
	
	// Output Logic (Combinational)
	always @(*) begin
		// Default values
		g = 3'b000;
		case (state)
			A: g = 3'b000;
			B: g[1] = 1'b1;
			C: g[2] = 1'b1;
			D: g[3] = 1'b1;
			default: g = 3'b000;
		endcase
	end
	
endmodule
