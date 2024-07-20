module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// Define the states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;

	// Define the current state and next state variables
	reg [1:0] current_state, next_state;

	// Define the state flip-flops
	always @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Define the state table
	always @(current_state, r) begin
		case (current_state)
			A: begin
				if (r[1] && r[2] && r[3]) begin
					next_state <= A;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end else if (r[1]) begin
					next_state <= B;
					g[1] <= 1;
					g[2] <= 0;
					g[3] <= 0;
				end else if (r[2]) begin
					next_state <= C;
					g[1] <= 0;
					g[2] <= 1;
					g[3] <= 0;
				end else if (~r[1] && ~r[2] && ~r[3]) begin
					next_state <= D;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end
			end
			B: begin
				if (r[1] && r[2] && r[3]) begin
					next_state <= A;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end else if (r[1]) begin
					next_state <= B;
					g[1] <= 1;
					g[2] <= 0;
					g[3] <= 0;
				end else if (~r[1]) begin
					next_state <= A;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end
			end
			C: begin
				if (r[1] && r[2] && r[3]) begin
					next_state <= A;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end else if (r[2]) begin
					next_state <= C;
					g[1] <= 0;
					g[2] <= 1;
					g[3] <= 0;
				end else if (~r[2]) begin
					next_state <= A;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end
			end
			D: begin
				if (r[1] && r[2] && r[3]) begin
					next_state <= A;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end else if (~r[1] && ~r[2] && ~r[3]) begin
					next_state <= D;
					g[1] <= 0;
					g[2] <= 0;
					g[3] <= 0;
				end
			end
		endcase
	end

endmodule
