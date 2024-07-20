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

	reg [1:0] state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (r[1]) begin
						state <= B;
					end else if (r[2]) begin
						state <= C;
					end else if (r[3]) begin
						state <= D;
					end
				end
				B: begin
					if (r[3] && !r[2] && !r[1]) begin
						state <= A;
					end
				end
				C: begin
					if (r[1] && !r[3] && !r[2]) begin
						state <= A;
					end
				end
				D: begin
					if (r[2] && !r[3] && !r[1]) begin
						state <= A;
					end
				end
			endcase
		end
	end

	always @(state) begin
		case (state)
			A: begin
				g[1] = r[1] ? 1 : 0;
				g[2] = r[2] ? 1 : 0;
				g[3] = r[3] ? 1 : 0;
			end
			B: begin
				g[1] = r[1] ? 1 : (g[1] ? 1 : 0);
				g[2] = r[2] ? 0 : 0;
				g[3] = r[3] ? 0 : 0;
			end
			C: begin
				g[1] = r[1] ? 0 : 0;
				g[2] = r[2] ? 1 : (g[2] ? 1 : 0);
				g[3] = r[3] ? 0 : 0;
			end
			D: begin
				g[1] = r[1] ? 0 : 0;
				g[2] = r[2] ? 0 : 0;
				g[3] = r[3] ? 1 : (g[3] ? 1 : 0);
			end
		endcase
	end

endmodule
