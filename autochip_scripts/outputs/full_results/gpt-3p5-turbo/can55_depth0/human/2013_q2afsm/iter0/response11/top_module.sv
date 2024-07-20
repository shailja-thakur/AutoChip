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

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	next_state = state;
	case(state)
		A: begin
			if (r[1] && ~r[2] && ~r[3]) begin
				next_state = A;
			end else if (r[1] && ~r[2] && ~r[3]) begin
				next_state = B;
			end else if (~r[1] && r[2] && ~r[3]) begin
				next_state = C;
			end else if (~r[1] && ~r[2] && ~r[3]) begin
				next_state = D;
			end
		end
		B: begin
			if (r[1] && ~r[2] && ~r[3]) begin
				next_state = B;
			end else if (r[1] && ~r[2] && ~r[3]) begin
				next_state = A;
			end
		end
		C: begin
			if (r[1] && ~r[2] && ~r[3]) begin
				next_state = C;
			end else if (r[1] && ~r[2] && ~r[3]) begin
				next_state = A;
			end
		end
		D: begin
			if (r[1] && ~r[2] && ~r[3]) begin
				next_state = A;
			end
		end
	endcase
end

assign g[1] = (state == B || state == A);
assign g[2] = (state == C || state == A);
assign g[3] = (state == A);

endmodule
