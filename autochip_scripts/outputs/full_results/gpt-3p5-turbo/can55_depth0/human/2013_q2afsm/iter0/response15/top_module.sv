module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state, next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state, r) begin
		g = 3'b000;

		case (state)
			A: begin
				if (r[1]) begin
					next_state = B;
					g[1] = 1;
				end else if (r[2]) begin
					next_state = C;
					g[2] = 1;
				end else if (r[3]) begin
					next_state = D;
					g[3] = 1;
				end else begin
					next_state = A;
				end
			end
			
			B: begin
				if (r[1]) begin
					next_state = B;
					g[1] = 1;
				end else begin
					next_state = A;
				end
			end
			
			C: begin
				if (r[2]) begin
					next_state = C;
					g[2] = 1;
				end else begin
					next_state = A;
				end
			end
			
			D: begin
				if (r[1] || r[2] || r[3]) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end
		endcase
	end

endmodule
