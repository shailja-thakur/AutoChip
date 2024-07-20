module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

	// Define state encoding
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;

	// Define registers for current state and next state
	reg [2:0] state_reg;
	reg [2:0] state_next;

	// Define outputs
	wire [2:0] g_temp;

	// State flip-flop
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= state_next;
		end
	end

	// State table
	always @(state_reg, r) begin
		case (state_reg)
			A: begin
				if (r[0]) begin
					state_next = B;
				end else if (r[1]) begin
					state_next = C;
				end else if (r[2]) begin
					state_next = D;
				end else begin
					state_next = A;
				end
			end

			B: begin
				if (r[0]) begin
					state_next = B;
				end else begin
					state_next = A;
				end
			end

			C: begin
				if (r[1]) begin
					state_next = C;
				end else begin
					state_next = A;
				end
			end

			D: begin
				state_next = A;
			end
		endcase
	end

	// Output assignment
	always @(state_reg, r) begin
		case (state_reg)
			A: begin
				g_temp[2:0] = 3'b000;
				if (r == 3'b100 || r == 3'b101 || r == 3'b110 || r == 3'b111) begin
					g_temp[0] = 1;
				end
				if (r == 3'b011 || r == 3'b111) begin
					g_temp[1] = 1;
				end
			end

			B: begin
				if (r == 3'b000) begin
					g_temp[2:0] = 3'b000;
				end else if (r == 3'b100 || r == 3'b101 || r == 3'b110 || r == 3'b111) begin
					g_temp[0] = 1;
				end
			end

			C: begin
				if (r == 3'b000) begin
					g_temp[2:0] = 3'b000;
				end else if (r == 3'b010 || r == 3'b011 || r == 3'b110 || r == 3'b111) begin
					g_temp[1] = 1;
				end
			end

			default: begin
				g_temp[2:0] = 3'b000;
			end
		endcase
	end

	// Output register
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			g <= 3'b000;
		end else begin
			g <= g_temp;
		end
	end

endmodule
