module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [3:0] state_reg;
	reg [3:0] state_next;

	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter S0 = 4'b0010;
	parameter S1 = 4'b0011;
	parameter S10 = 4'b0100;
	parameter G1 = 4'b0101;
	parameter G2 = 4'b0110;
	parameter P0 = 4'b0111;
	parameter P1 = 4'b1000;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= state_next;
		end
	end

	always @(state_reg or x) begin
		case(state_reg)
			A: begin
				if (x) begin
					state_next = B;
				end else begin
					state_next = S0;
				end
			end
			B: begin
				state_next = S0;
			end
			S0: begin
				if (x) begin
					state_next = S1;
				end else begin
					state_next = S0;
				end
			end
			S1: begin
				if (x) begin
					state_next = S1;
				end else begin
					state_next = S10;
				end
			end
			S10: begin
				if (x) begin
					state_next = G1;
				end else begin
					state_next = S0;
				end
			end
			G1: begin
				if (y) begin
					state_next = P1;
				end else begin
					state_next = G2;
				end
			end
			G2: begin
				if (y) begin
					state_next = P1;
				end else begin
					state_next = P0;
				end
			end
			P0: begin
				state_next = P0;
			end
			P1: begin
				state_next = P1;
			end
			default: begin
				state_next = A;
			end
		endcase
	end

	always @(state_reg) begin
		case(state_reg)
			B: begin
				f = 1'b1;
			end
			G1, G2, P1: begin
				g = 1'b1;
			end
			default: begin
				f = 1'b0;
				g = 1'b0;
			end
		endcase
	end

endmodule
