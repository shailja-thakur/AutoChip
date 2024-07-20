module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	// Define states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	
	reg [2:0] state, next_state;
	
	// Output assignments
	assign g[1] = (state == B || state == D) ? 1'b1 : 1'b0;
	assign g[2] = (state == C) ? 1'b1 : 1'b0;
	assign g[3] = (state == A && r == 3'b000) ? 1'b1 : 1'b0;
	
	// State transition logic
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Next state logic
	always @(state, r) begin
		case (state)
			A: begin
				if (r == 3'b000) begin
					next_state <= A;
				end else if (r == 3'b001) begin
					next_state <= B;
				end else if (r == 3'b010) begin
					next_state <= C;
				end else begin
					next_state <= D;
				end
			end
			
			B: begin
				if (r == 3'b001) begin
					next_state <= B;
				end else begin
					next_state <= A;
				end
			end
			
			C: begin
				if (r == 3'b010) begin
					next_state <= C;
				end else begin
					next_state <= A;
				end
			end
			
			D: begin
				if (r == 3'b000) begin
					next_state <= D;
				end else begin
					next_state <= A;
				end
			end
		endcase
	end
	
endmodule
