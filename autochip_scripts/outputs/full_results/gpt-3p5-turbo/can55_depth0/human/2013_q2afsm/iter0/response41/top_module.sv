module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= A;
	else
		state <= next_state;
end

always @(state or r) begin
	case (state)
		A:
			begin
				if (r[1] & ~r[2] & ~r[3])
					next_state = A;
				else if (r[1])
					next_state = B;
				else if (~r[1] & r[2])
					next_state = C;
				else if (~r[1] & ~r[2] & ~r[3])
					next_state = D;
			end
		B:
			begin
				if (r[1])
					next_state = B;
				else if (~r[1])
					next_state = A;
			end
		C:
			begin
				if (r[2])
					next_state = C;
				else if (~r[2])
					next_state = A;
			end
		default:
			next_state = A;
	endcase
end

always @(state) begin
	case (state)
		A:
			begin
				g[1] = r[1] & (~r[2] | ~r[3]);
				g[2] = r[2] & (~r[1] | ~r[3]);
				g[3] = r[3] & (~r[1] | ~r[2]);
			end
		B:
			begin
				g[1] = r[1] & g[1];
				g[2] = r[2] & (~r[1] | ~r[3]);
				g[3] = r[3] & (~r[1] | ~r[2]);
			end
		C:
			begin
				g[1] = r[1] & (~r[2] | ~r[3]);
				g[2] = r[2] & g[2];
				g[3] = r[3] & (~r[1] | ~r[2]);
			end
		default:
			begin
				g[1] = r[1] & (~r[2] | ~r[3]);
				g[2] = r[2] & (~r[1] | ~r[3]);
				g[3] = r[3] & (~r[1] | ~r[2]);
			end
	endcase
end

endmodule
