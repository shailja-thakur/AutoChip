module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
wire [3:1] g_temp;

// Output assignments
assign g = g_temp;

// State codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

// State flip-flop
always @(posedge clk or negedge resetn)
begin
	if (~resetn)
		state <= A;
	else
		state <= next_state;
end

// Next state logic
always @(*)
begin
	case (state)
		A:
		begin
			if (r[1] & r[2] & r[3])
				next_state = A;
			else if (r[1] & ~r[2] & ~r[3])
				next_state = B;
			else if (~r[1] & r[2] & ~r[3])
				next_state = C;
			else if (~r[1] & ~r[2] & ~r[3])
				next_state = D;
			else
				next_state = A;
		end
		B:
		begin
			if (g_temp[1] & r[1])
				next_state = B;
			else if (g_temp[1] & ~r[1])
				next_state = A;
			else
				next_state = B;
		end
		C:
		begin
			if (g_temp[2] & r[2])
				next_state = C;
			else if (g_temp[2] & ~r[2])
				next_state = A;
			else
				next_state = C;
		end
		D:
		begin
			if (r[1] & r[2] & r[3])
				next_state = A;
			else if (r[1] & ~r[2] & ~r[3])
				next_state = B;
			else if (~r[1] & r[2] & ~r[3])
				next_state = C;
			else if (~r[1] & ~r[2] & ~r[3])
				next_state = D;
			else
				next_state = A;
		end
		default:
			next_state = A;
	endcase
end

// Output assignments based on state
assign g_temp[1] = (state == B) ? 1'b1 : 1'b0;
assign g_temp[2] = (state == C) ? 1'b1 : 1'b0;
assign g_temp[3] = (state == D) ? 1'b1 : 1'b0;

endmodule
