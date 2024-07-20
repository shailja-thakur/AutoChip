module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
wire [3:1] g_int;

// State definitions
parameter A = 3'b001;
parameter B = 3'b010;
parameter C = 3'b011;
parameter D = 3'b100;

// State flip-flop
always @(posedge clk, negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Next state logic
always @(state, r) begin
	case (state)
		A: begin
			if (r[1] & ~r[2] & ~r[3]) begin
				next_state = A;
			end else if (~r[1] & ~r[2] & ~r[3]) begin
				next_state = A;
			end else if (r[1]) begin
				next_state = B;
			end else if (~r[1] & r[2]) begin
				next_state = C;
			end else if (~r[1] & ~r[2] & ~r[3]) begin
				next_state = D;
			end
		end
		
		B: begin
			if (g_int[1] & r[1]) begin
				next_state = B;
			end else if (g_int[1] & ~r[1]) begin
				next_state = A;
			end else if (~r[1] & ~r[2] & ~r[3]) begin
				next_state = A;
			end
		end
		
		C: begin
			if (g_int[2] & r[2]) begin
				next_state = C;
			end else if (g_int[2] & ~r[2]) begin
				next_state = A;
			end else if (~r[1] & ~r[2] & ~r[3]) begin
				next_state = A;
			end
		end
		
		D: begin
			if (~r[1] & ~r[2] & ~r[3]) begin
				next_state = D;
			end else if (r[1]) begin
				next_state = B;
			end else if (~r[1] & r[2]) begin
				next_state = C;
			end else if (~r[1] & ~r[2] & ~r[3]) begin
				next_state = D;
			end
		end
	endcase
end

// Output logic
always @(state) begin
	case (state)
		A: begin
			g_int[1] = r[1];
			g_int[2] = r[2];
			g_int[3] = r[3];
		end
		
		B: begin
			g_int[1] = r[1];
			g_int[2] = 0;
			g_int[3] = 0;
		end
		
		C: begin
			g_int[1] = 0;
			g_int[2] = r[2];
			g_int[3] = 0;
		end
		
		D: begin
			g_int[1] = 0;
			g_int[2] = 0;
			g_int[3] = 0;
		end
	endcase
end

assign g = g_int;

endmodule
