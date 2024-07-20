module FSM (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);
	
	reg [3:0] state;
	wire r1, r2, r3;
	assign {r1, r2, r3} = r;
	
	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter C = 4'b0010;
	parameter D = 4'b0011;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else begin
			case (state)
				A: begin
					if (!r1 && !r2 && !r3)
						state <= A;
					else if (r1)
						state <= B;
					else if (!r1 && r2)
						state <= C;
					else if (!r1 && !r2 && !r3)
						state <= D;
				end
				B: begin
					if (r1 && g[1])
						state <= B;
					else if (!r1 && !g[1])
						state <= A;
				end
				C: begin
					if (r2 && g[2])
						state <= C;
					else if (!r2 && !g[2])
						state <= A;
				end
				D: begin
					if (r1 || r2 || r3)
						state <= A;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			A: begin
				g[1] <= 1'b1;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end
			B: begin
				g[1] <= 1'b1;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end
			C: begin
				g[1] <= 1'b0;
				g[2] <= 1'b1;
				g[3] <= 1'b0;
			end
			D: begin
				g[1] <= 1'b0;
				g[2] <= 1'b0;
				g[3] <= 1'b0;
			end
		endcase
	end
	
endmodule
module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	FSM fsm (
		.clk(clk),
		.resetn(resetn),
		.r(r),
		.g(g)
	);
	
endmodule
