module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// State codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// State flip-flops
	reg [1:0] state, next_state;
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
    
	// State table
	always @(state, r) begin
		case (state)
			
			A: begin
				if (r[1] & !r[2] & !r[3])
					next_state = D;
				else if (r[1])
					next_state = B;
				else if (!r[1] & r[2])
					next_state = C;
				else
					next_state = A;
			end
			
			B: begin
				if (r[1] & g[1])
					next_state = B;
				else if (r[1] & !g[1])
					next_state = A;
				else
					next_state = B;
			end
			
			C: begin
				if (r[2] & g[2])
					next_state = C;
				else if (r[2] & !g[2])
					next_state = A;
				else
					next_state = C;
			end
			
			D: begin
				next_state = A;
			end
			
		endcase
	end
	
	// Outputs
	assign g[1] = (state == A) & r[1];
	assign g[2] = (state == B) & r[2];
	assign g[3] = (state == C) & r[3];
		
endmodule
