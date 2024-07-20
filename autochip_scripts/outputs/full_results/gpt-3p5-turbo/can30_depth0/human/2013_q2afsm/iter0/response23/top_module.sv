module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= A;
	else
		state <= next_state;
end

always @(state or r) begin
	case (state)
		A: begin
			if (r[1] == 1'b1 && r[2] == 1'b1 && r[3] == 1'b1)
				next_state = D;
			else if (r[1] == 1'b1)
				next_state = B;
			else if (r[2] == 1'b1)
				next_state = C;
			else
				next_state = A;
		end
		B: begin
			if (r[1] == 1'b1)
				next_state = B;
			else
				next_state = A;
		end
		C: begin
			if (r[2] == 1'b1)
				next_state = C;
			else
				next_state = A;
		end
		D: begin
			next_state = A;
		end
	endcase
end

assign g[1] = (state == B || state == D) ? 1'b1 : 1'b0;
assign g[2] = (state == C || state == D) ? 1'b1 : 1'b0;
assign g[3] = (state == D) ? 1'b1 : 1'b0;

endmodule
