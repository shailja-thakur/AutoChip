module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;

	reg [1:0] state, next_state;
	reg f, g;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		next_state = state;
		case (state)
			A: begin
				if (resetn) begin
					next_state = B;
					f = 1;
				end			
			end
			B: begin
				if (x) begin
					next_state = C;
				end			
			end
			C: begin
				if (x) begin
					next_state = A;
					g = 1;
				end else begin
					if (y) begin
						next_state = A;
						g = 1;
					end else begin
						next_state = A;
						g = 0;
					end
				end
			end
		endcase
	end

endmodule
