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

// State flip-flop
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
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
			if (r[1] == 1 && g[1] == 1) begin
				next_state = B;
			end else if (r[1] == 0 && g[1] == 1) begin
				next_state = A;
			end else begin
				next_state = B;
			end
		end
		C: begin
			if (r[2] == 1 && g[2] == 1) begin
				next_state = C;
			end else if (r[2] == 0 && g[2] == 1) begin
				next_state = A;
			end else begin
				next_state = C;
			end
		end
		default: next_state = A;
	endcase
end

// Continuous assignment for outputs
assign g[1] = (state == B) ? 1'b1 : 1'b0;
assign g[2] = (state == C) ? 1'b1 : 1'b0;
assign g[3] = (state == A && r[2] == 0 && r[1] == 0 && r[3] == 0) ? 1'b1 : 1'b0;

endmodule
