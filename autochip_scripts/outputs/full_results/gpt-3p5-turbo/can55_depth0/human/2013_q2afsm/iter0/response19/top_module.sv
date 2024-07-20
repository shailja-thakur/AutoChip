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
	if (~resetn) begin
		state <= A;
	end
	else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		A: begin
			if (r[1] & ~r[2] & ~r[3])
				next_state = A;
			else if (~r[1] & r[2] & ~r[3])
				next_state = C;
			else if (~r[1] & ~r[2] & r[3])
				next_state = D;
			else if (r[1])
				next_state = B;
			else
				next_state = A;
		end

		B: begin
			if (r[1] & ~r[2] & ~r[3])
				next_state = A;
			else if (r[1] & ~r[2] & ~r[3] & g[1])
				next_state = B;
			else
				next_state = A;
		end

		C: begin
			if (r[1] & ~r[2] & ~r[3])
				next_state = A;
			else if (~r[1] & r[2] & ~r[3])
				next_state = C;
			else
				next_state = A;
		end

		D: begin
			if (r[1] & ~r[2] & ~r[3])
				next_state = A;
			else
				next_state = D;
		end
	endcase
end

always @(state) begin
	case (state)
		A: begin
			g[1] = r[1];
			g[2] = 0;
			g[3] = 0;
		end

		B: begin
			g[1] = r[1] | g[1];
			g[2] = 0;
			g[3] = 0;
		end

		C: begin
			g[1] = r[1];
			g[2] = r[2];
			g[3] = 0;
		end

		D: begin
			g[1] = r[1];
			g[2] = 0;
			g[3] = r[3];
		end
	endcase
end

endmodule
