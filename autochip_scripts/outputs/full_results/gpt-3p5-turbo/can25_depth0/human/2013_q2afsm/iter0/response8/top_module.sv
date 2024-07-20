module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state; // FSM state

// Register for each request signal
reg [1:0] r1_reg;
reg [1:0] r2_reg;
reg [1:0] r3_reg;

// Register for each grant signal
reg [1:0] g1_reg;
reg [1:0] g2_reg;
reg [1:0] g3_reg;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		// Reset state and all registers on reset
		state <= A;
		r1_reg <= 2'b00;
		r2_reg <= 2'b00;
		r3_reg <= 2'b00;
		g1_reg <= 2'b00;
		g2_reg <= 2'b00;
		g3_reg <= 2'b00;
	end else begin
		// State transition logic
		case (state)
			A: begin
				if (r1_reg[0] || r2_reg[1]) begin
					if (r1_reg[0]) begin
						state <= B;
					end else if (r2_reg[1]) begin
						state <= C;
					end
				end else if (r1_reg[1] || r2_reg[1] || r3_reg[1]) begin
					state <= D;
				end
			end
			B: begin
				if (g1_reg[0] && r1_reg[0]) begin
					state <= B;
				end else begin
					state <= A;
				end
			end
			C: begin
				if (g2_reg[1] && r2_reg[1]) begin
					state <= C;
				end else begin
					state <= A;
				end
			end
			D: begin
				state <= A;
			end
		endcase
	end
end

always @(posedge clk) begin
	// Update request registers
	r1_reg <= r[1];
	r2_reg <= r[2];
	r3_reg <= r[3];

	// Update grant registers
	case (state)
		A: begin
			if (r1_reg[1]) begin
				g1_reg <= 2'b10;
				g2_reg <= 2'b00;
				g3_reg <= 2'b00;
			end else if (r2_reg[1]) begin
				g1_reg <= 2'b00;
				g2_reg <= 2'b10;
				g3_reg <= 2'b00;
			end else if (r3_reg[1]) begin
				g1_reg <= 2'b00;
				g2_reg <= 2'b00;
				g3_reg <= 2'b10;
			end else begin
				g1_reg <= 2'b00;
				g2_reg <= 2'b00;
				g3_reg <= 2'b00;
			end
		end
		B: begin
			if (g1_reg[0] && r1_reg[0]) begin
				g1_reg <= 2'b11;
			end else begin
				g1_reg <= 2'b00;
			end
			g2_reg <= 2'b00;
			g3_reg <= 2'b00;
		end
		C: begin
			g1_reg <= 2'b00;
			if (g2_reg[1] && r2_reg[1]) begin
				g2_reg <= 2'b11;
			end else begin
				g2_reg <= 2'b00;
			end
			g3_reg <= 2'b00;
		end
		D: begin
			g1_reg <= 2'b00;
			g2_reg <= 2'b00;
			g3_reg <= 2'b00;
		end
	endcase
end

// Assign outputs
assign g[1] = g1_reg[0];
assign g[2] = g2_reg[1];
assign g[3] = g3_reg[1];

endmodule
