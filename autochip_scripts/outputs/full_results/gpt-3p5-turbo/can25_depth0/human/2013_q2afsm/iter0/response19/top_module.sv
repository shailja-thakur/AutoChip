module top_module (
input clk,
input resetn,
input [3:1] r,
output [3:1] g
);
	
	reg [3:1] state, next_state;
	assign g = state[1:3];
	
	parameter A = 3'd1;
	parameter B = 3'd2;
	parameter C = 3'd3;
	parameter D = 3'd4;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or r) begin
		case (state)
			A: begin
				if (r[1] == 1'b1 && r[2] == 1'b1 && r[3] == 1'b1) begin
					next_state = A;
				end else if (r[1] == 1'b1) begin
					next_state = B;
				end else if (r[2] == 1'b1) begin
					next_state = C;
				end else if (r[3] == 1'b1) begin
					next_state = D;
				end
			end
			
			B: begin
				if (r[1] == 1'b1) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			
			C: begin
				if (r[2] == 1'b1) begin
					next_state = C;
				end else begin
					next_state = A;
				end
			end
			
			D: begin
				next_state = A;
			end
		endcase
	end
endmodule
