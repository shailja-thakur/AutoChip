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
reg [3:1] g_reg;

// State flip-flop
always @(posedge clk or negedge resetn) begin
	if (resetn == 0) begin
		state <= A;
		g_reg <= 3'b000;
	end else begin
		state <= next_state;
	end
end

// State table
always @(state or r) begin
	case (state)
		A: begin
			if (r == 3'b000) begin
				next_state = A;
				g_reg = 3'b000;
			end else if (r == 3'b100) begin
				next_state = B;
				g_reg = 3'b001;
			end else if (r == 3'b010) begin
				next_state = C;
				g_reg = 3'b010;
			end else if (r == 3'b000) begin
				next_state = D;
				g_reg = 3'b000;
			end
		end
		B: begin
			if (r == 3'b100) begin
				next_state = B;
				g_reg = 3'b001;
			end else if (r == 3'b000) begin
				next_state = A;
				g_reg = 3'b000;
			end
		end
		C: begin
			if (r == 3'b010) begin
				next_state = C;
				g_reg = 3'b010;
			end else if (r == 3'b000) begin
				next_state = A;
				g_reg = 3'b000;
			end
		end
		D: begin
			if (r == 3'b000) begin
				next_state = D;
				g_reg = 3'b000;
			end else begin
				next_state = A;
				g_reg = 3'b000;
			end
		end
		default: next_state = A;
	endcase
end

// Continuous assignment for outputs
assign g[1] = g_reg[1];
assign g[2] = g_reg[2];
assign g[3] = g_reg[3];

endmodule
