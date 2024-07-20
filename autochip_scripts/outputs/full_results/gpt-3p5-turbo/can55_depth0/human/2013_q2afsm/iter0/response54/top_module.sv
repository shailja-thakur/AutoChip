module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// State parameter
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// State and next state registers
	reg [1:0] state_reg;
	reg [1:0] next_state_reg;
	
	// Outputs
	assign g[1] = (state_reg == B || (state_reg == A && r[1] && !r[2] && !r[3])) ? 1'b1 : 1'b0;
	assign g[2] = (state_reg == C || (state_reg == A && !r[1] && r[2] && !r[3])) ? 1'b1 : 1'b0;
	assign g[3] = (state_reg == A && !r[1] && !r[2] && !r[3]) ? 1'b1 : 1'b0;
	
	// State transition logic
	always @(posedge clk) begin
		if (!resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state_reg;
		end
	end
	
	// Next state logic
	always @(*) begin
		case (state_reg)
			A: begin
				if (r[1] && !r[2] && !r[3])
					next_state_reg = D;
				else if (r[1])
					next_state_reg = B;
				else if (!r[1] && r[2])
					next_state_reg = C;
				else
					next_state_reg = A;
			end
			
			B: begin
				if (r[1])
					next_state_reg = B;
				else
					next_state_reg = g[1] ? A : B;
			end
			
			C: begin
				if (r[2])
					next_state_reg = C;
				else
					next_state_reg = g[2] ? A : C;
			end
			
			D: begin
				next_state_reg = A;
			end
		endcase
	end
	
endmodule
