module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// FSM states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter S0 = 3'b010;
	parameter S1 = 3'b011;
	parameter S10 = 3'b100;
	parameter G1 = 3'b101;
	parameter G2 = 3'b110;
	parameter P0 = 3'b111;
	parameter P1 = 3'b111;

	// Registers
	reg [2:0] state_reg;
	reg [2:0] state_next;
	reg f_reg;
	reg g_reg;

	// Assign outputs
	assign f = f_reg;
	assign g = g_reg;

	// Next state logic
	always @ (posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= state_next;
		end
	end

	// State transition logic
	always @ (*) begin
		case (state_reg)
			A: begin
				state_next = B;
			end
			B: begin
				state_next = S0;
			end
			S0: begin
				if (x == 1) begin
					state_next = S1;
				end else begin
					state_next = S0;
				end
			end
			S1: begin
				if (x == 1) begin
					state_next = S1;
				end else begin
					state_next = S10;
				end
			end
			S10: begin
				if (x == 1) begin
					state_next = G1;
				end else begin
					state_next = S0;
				end
			end
			G1: begin
				if (y == 1) begin
					state_next = P1;
				end else begin
					state_next = G2;
				end
			end
			G2: begin
				if (y == 1) begin
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
		endcase
	end

	// Output assignments based on state
	always @ (*) begin
		case (state_reg)
			B: begin
				f_reg = 1;
			end
			G1, G2, P1: begin
				g_reg = 1;
			end
			default: begin
				f_reg = 0;
				g_reg = 0;
			end
		endcase
	end

endmodule
