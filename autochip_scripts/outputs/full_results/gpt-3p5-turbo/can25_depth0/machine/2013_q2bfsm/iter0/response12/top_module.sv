module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
	
	reg [3:0] state_reg;
	reg [2:0] next_state;

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter S0 = 2'b10;
	parameter S1 = 2'b11;
	parameter S10 = 2'b100;
	parameter G1 = 2'b101;
	parameter G2 = 2'b110;
	parameter P0 = 2'b111;
	parameter P1 = 2'b000;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state;
		end
	end
	
	always @* begin
		case (state_reg)
			A: begin
				next_state = B;
			end
			B: begin
				next_state = S0;
			end
			S0: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
			end
			S1: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S10;
				end
			end
			S10: begin
				if (x) begin
					next_state = G1;
				end else begin
					next_state = S0;
				end
			end
			G1: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = G2;
				end
			end
			G2: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = P0;
				end
			end
			P0: begin
				next_state = P0;
			end
			P1: begin
				next_state = P1;
			end
			default: begin
				next_state = A;
			end
		endcase
	end
	
	assign f = (state_reg == B) ? 1'b1 : 1'b0;
	assign g = ((state_reg == G1) || (state_reg == G2) || (state_reg == P1)) ? 1'b1 : 1'b0;

endmodule
