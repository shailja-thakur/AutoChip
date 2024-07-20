module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;
wire x_valid, g_enable;


// State A : beginning state
parameter A = 2'b00;
// State B : waiting for x = 1
parameter B = 2'b01;
// State C : waiting for x = 0
parameter C = 2'b10;
// State D : waiting for x = 1
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end
	else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		A: begin
			f = 0;
			g = 0;
			if (resetn) begin
				if (x == 1'b0) begin
					next_state = B;
				end
				else begin
					next_state = A;
				end
			end
		end
		B: begin
			f = 0;
			g = 0;
			if (resetn) begin
				if (x == 1'b1) begin
					next_state = C;
				end
				else begin
					next_state = B;
				end
			end
		end
		C: begin
			f = 0;
			g = 0;
			if (resetn) begin
				if (x == 1'b0) begin
					next_state = D;
				end
				else begin
					next_state = B;
				end
			end
		end
		D: begin
			f = 1;
			if (resetn) begin
				if (x == 1'b1) begin
					next_state = A;
				end
				else begin
					next_state = B;
				end
			end
		end
		default: begin
			f = 0;
			g = 0;
			next_state = A;
		end
	endcase
end

assign x_valid = (x == 1'bx) ? 0 : 1;
assign g_enable = (g == 1 && y == 1) ? 1 : 0;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		g <= 0;
	end
	else begin
		case (state)
			A: begin
				if (x_valid) begin
					g <= 0;
				end
			end
			D: begin
				if (g_enable) begin
					g <= 1;
				end
				else if (y == 1'bx) begin
					g <= g;
				end
				else begin
					g <= 0;
				end
			end
			default: begin
				g <= g;
			end
		endcase
	end
end

endmodule
