module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

	// State definitions
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// State flip-flops
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	// Outputs
	assign g[1] = (current_state == B || current_state == D) ? 1 : 0;
	assign g[2] = (current_state == C) ? 1 : 0;
	assign g[3] = (current_state == A && !r[2]) ? 1 : 0;
	
	// State transition logic
	always @(posedge clk, negedge resetn) begin
		if (!resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// State table
	always @(current_state, r) begin
		case (current_state)
			A: begin
				if (!r[1] && !r[2] && !r[3]) begin
					next_state <= A;
				end else if (r[1] && !r[2] && !r[3]) begin
					next_state <= B;
				end else if (!r[1] && r[2] && !r[3]) begin
					next_state <= C;
				end else if (!r[1] && !r[2] && !r[3]) begin
					next_state <= D;
				end
			end
			
			B: begin
				if (r[1] && g[1]) begin
					next_state <= B;
				end else if (r[1] && !g[1]) begin
					next_state <= A;
				end
			end
			
			C: begin
				if (r[2] && g[2]) begin
					next_state <= C;
				end else if (r[2] && !g[2]) begin
					next_state <= A;
				end
			end
			
			D: begin
				next_state <= A;
			end
		endcase
	end
	
endmodule
