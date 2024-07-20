module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	parameter A = 0, B = 1, S0 = 2, S1 = 3, S10 = 4, G1 = 5, G2 = 6, P0 = 7, P1 = 8;
	
	reg [3:0] state;
	reg f, g;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
			f <= 0;
			g <= 0;
		end else begin
			case(state)
				A: begin
					if (x) begin
						state <= B;
					end else begin
						state <= S0;
					end
				end
				B: begin
					state <= S0;
				end
				S0: begin
					if (x) begin
						state <= S1;
					end else begin
						state <= S0;
					end
				end
				S1: begin
					if (x) begin
						state <= S1;
					end else begin
						state <= S10;
					end
				end
				S10: begin
					if (x) begin
						state <= G1;
					end else begin
						state <= S0;
					end
				end
				G1: begin
					if (y) begin
						state <= P1;
					end else begin
						state <= G2;
					end
				end
				G2: begin
					if (y) begin
						state <= P1;
					end else begin
						state <= P0;
					end
				end
				P0: begin
					state <= P0;
				end
				P1: begin
					state <= P1;
				end
				default: begin
					state <= A;
					f <= 0;
					g <= 0;
				end
			endcase
		end
	end

	always @(state) begin
		case(state)
			B: begin
				f <= 1;
			end
			G1, G2, P1: begin
				g <= 1;
			end
			default: begin
				f <= 0;
				g <= 0;
			end
		endcase
	end

endmodule
