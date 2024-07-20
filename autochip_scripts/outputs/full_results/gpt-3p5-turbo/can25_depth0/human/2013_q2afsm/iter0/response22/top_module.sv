module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		current_state <= A;
	else
		current_state <= next_state;
end

always @(current_state, r) begin
	next_state = current_state;
	case (current_state)
		A: begin
			if (r[1] & ~r[2] & ~r[3])
				next_state <= A;
			else if (r[1])
				next_state <= B;
			else if (~r[1] & r[2])
				next_state <= C;
			else if (~r[1] & ~r[2] & ~r[3])
				next_state <= D;
		end
		B: begin
			if (r[1] & g[1])
				next_state <= B;
			else if (~r[1] & g[1])
				next_state <= A;
		end
		C: begin
			if (r[2] & g[2])
				next_state <= C;
			else if (~r[2] & g[2])
				next_state <= A;
		end
		D: begin
			if (r[1] & ~r[2] & ~r[3])
				next_state <= A;
		end
	endcase
end

always @(current_state) begin
	case (current_state)
		A: begin
			g[1] <= (r[1] & ~r[2] & ~r[3]);
			g[2] <= 0;
			g[3] <= 0;
		end
		B: begin
			g[1] <= (r[1] & g[1]);
			g[2] <= 0;
			g[3] <= 0;
		end
		C: begin
			g[1] <= 0;
			g[2] <= (r[2] & g[2]);
			g[3] <= 0;
		end
		D: begin
			g[1] <= 0;
			g[2] <= 0;
			g[3] <= 0;
		end
	endcase
end
endmodule
