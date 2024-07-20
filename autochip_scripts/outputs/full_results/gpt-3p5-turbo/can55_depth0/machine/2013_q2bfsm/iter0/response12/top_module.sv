module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	reg [3:0] state;

	parameter A = 4'b0000; // State A
	parameter B = 4'b0001; // State B
	parameter S0 = 4'b0010; // State S0
	parameter S1 = 4'b0011; // State S1
	parameter S10 = 4'b0100; // State S10
	parameter G1 = 4'b0101; // State G1
	parameter G2 = 4'b0110; // State G2
	parameter P0 = 4'b0111; // State P0
	parameter P1 = 4'b1000; // State P1

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			case (state)
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
			endcase
		end
	end

	always @(*) begin
		f = (state == B);
		g = (state == G1 || state == G2 || state == P1);
	end

endmodule
