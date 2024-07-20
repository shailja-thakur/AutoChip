module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Define states using parameter
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter S0 = 2'b10;
	parameter S1 = 2'b11;
	parameter S10 = 2'b100;
	parameter G1 = 2'b101;
	parameter G2 = 2'b110;
	parameter P0 = 2'b111;
	parameter P1 = 2'b1000;

	// Define state register
	reg [3:0] state_reg, state_next;

	// Define output logic
	assign f = (state_reg == B) ? 1'b1 : 1'b0;
	assign g = (state_reg == G1 || state_reg == G2 || state_reg == P1) ? 1'b1 : 1'b0;

	// Define next state logic
	always @(posedge clk, negedge resetn) begin
		if(!resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= state_next;
		end
	end

	// Define state transition logic
	always @(state_reg, x, y) begin
		case(state_reg)
			A: begin
				state_next = B;
			end
			B: begin
				state_next = S0;
			end
			S0: begin
				if(x) begin
					state_next = S1;
				end else begin
					state_next = S0;
				end
			end
			S1: begin
				if(x) begin
					state_next = S1;
				end else begin
					state_next = S10;
				end
			end
			S10: begin
				if(x) begin
					state_next = G1;
				end else begin
					state_next = S0;
				end
			end
			G1: begin
				if(y) begin
					state_next = P1;
				end else begin
					state_next = G2;
				end
			end
			G2: begin
				if(y) begin
					state_next = P1;
				end else begin
					state_next = P0;
				end
			end
			P0, P1: begin
				state_next = state_reg;
			end
		endcase
	end

endmodule
