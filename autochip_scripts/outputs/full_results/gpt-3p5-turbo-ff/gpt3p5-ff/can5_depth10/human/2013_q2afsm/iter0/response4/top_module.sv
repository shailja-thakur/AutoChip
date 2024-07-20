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
	reg [3:1] g;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A;
		else begin
			case (state)
				A: begin
					if (r[1] && r[2] && r[3])
						state <= A;
					else if (r[1])
						state <= B;
					else if (r[2])
						state <= C;
					else if (r[3])
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
					state <= A;
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			A: begin
				g[1] = r[1] && ~r[2] && ~r[3];
				g[2] = r[2] && ~r[1] && ~r[3];
				g[3] = r[3] && ~r[1] && ~r[2];
			end
			B: begin
				g[1] = r[1];
				g[2] = 0;
				g[3] = 0;
			end
			C: begin
				g[1] = 0;
				g[2] = r[2];
				g[3] = 0;
			end
			D: begin
				g[1] = 0;
				g[2] = 0;
				g[3] = 0;
			end
		endcase
	end
endmodule
