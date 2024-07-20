module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state;
	
	// Assign initial state
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= state;
	end
	
	// Outputs
	assign g[1] = (state == B || state == D) && r[1];
	assign g[2] = (state == C || state == D) && r[2];
	assign g[3] = state == D && r[3];
	
	// State transitions
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else begin
			case(state)
				A: begin
					if (r[1] && !r[2] && !r[3])
						state <= B;
					else if (!r[1] && r[2] && !r[3])
						state <= C;
					else if (!r[1] && !r[2] && !r[3])
						state <= D;
				end
				B: begin
					if (r[1])
						state <= B;
					else
						state <= A;
				end
				C: begin
					if (r[2])
						state <= C;
					else
						state <= A;
				end
				D: begin
					if (r[1] && !r[2] && !r[3])
						state <= B;
					else if (!r[1] && r[2] && !r[3])
						state <= C;
					else if (!r[1] && !r[2] && !r[3])
						state <= D;
				end
			endcase
		end
	end
	
endmodule
