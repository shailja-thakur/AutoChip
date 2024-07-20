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
	parameter S0 = 2;
	parameter S1 = 3;
	parameter S10 = 4;
	parameter G1 = 5;
	parameter G2 = 6;
	parameter P0 = 7;
	parameter P1 = 8;
	
	reg [3:0] state;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (x) begin
						state <= B;
					end
				end
				
				B: begin
					state <= S0;
				end
				
				S0: begin
					if (x) begin
						state <= S1;
					end
					else begin
						state <= S0;
					end
				end
				
				S1: begin
					if (x) begin
						state <= S1;
					end
					else begin
						state <= S10;
					end
				end
				
				S10: begin
					if (x) begin
						state <= G1;
					end
					else begin
						state <= S0;
					end
				end
				
				G1: begin
					if (y) begin
						state <= P1;
					end
					else begin
						state <= G2;
					end
				end
				
				G2: begin
					if (y) begin
						state <= P1;
					end
					else begin
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
	
	assign f = (state == B) ? 1'b1 : 1'b0;
	assign g = (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;
	
endmodule
