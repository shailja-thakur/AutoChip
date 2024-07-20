module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// State codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			case(state)
				A: begin
					if (r[1] & !r[2] & !r[3]) begin
						state <= D;
					end else if (!r[1] & r[2]) begin
						state <= C;
					end else if (r[1]) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				B: begin
					if (r[1]) begin
						state <= B;
					end else if (g[1]) begin
						state <= A;
					end
				end
				C: begin
					if (r[2]) begin
						state <= C;
					end else if (g[2]) begin
						state <= A;
					end
				end
				default: begin
					state <= A;
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			A: begin
				g[1] <= 0;
				g[2] <= 0;
				g[3] <= 0;
			end
			B: begin
				if (g[1]) begin
					g[2] <= 0;
					g[3] <= 0;
				end
			end
			C: begin
				if (g[2]) begin
					g[1] <= 0;
					g[3] <= 0;
				end
			end
			D: begin
				g[1] <= 0;
				g[2] <= 0;
				g[3] <= 0;
			end
			default: begin
				g[1] <= 0;
				g[2] <= 0;
				g[3] <= 0;
			end
		endcase
	end
	
endmodule
