module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;
reg [1:0] g_reg;

// State flip-flop
always @(posedge clk) begin
	if (resetn == 0) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// State table
always @(state or r) begin
	case (state)
		A: begin
			if (r[1] == 0 && r[2] == 0 && r[3] == 0) begin
				next_state = A;
			end else if (r[1] == 1) begin
				next_state = B;
			end else if (r[1] == 0 && r[2] == 1) begin
				next_state = C;
			end else begin
				next_state = D;
			end
		end
		B: begin
			if (r[1] == 1 && g_reg[1] == 1) begin
				next_state = B;
			end else if (r[1] == 0 && g_reg[1] == 1) begin
				next_state = A;
			end
		end
		C: begin
			if (r[2] == 1 && g_reg[2] == 1) begin
				next_state = C;
			end else if (r[2] == 0 && g_reg[2] == 1) begin
				next_state = A;
			end
		end
		default: next_state = A;
	endcase
end

// Continuous assignment for outputs
always @(state or next_state) begin
	case (state)
		A: g_reg <= (r[2] == 0 && r[1] == 0 && r[3] == 0) ? 3'b001 : 3'b000;
		B: g_reg <= 3'b010;
		C: g_reg <= 3'b100;
		default: g_reg <= 3'b000;
	endcase
end

// Output register
always @(posedge clk) begin
	g <= g_reg;
end

endmodule
