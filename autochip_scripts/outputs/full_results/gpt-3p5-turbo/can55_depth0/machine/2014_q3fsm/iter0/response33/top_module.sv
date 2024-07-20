module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

localparam A = 0;
localparam B = 1;
localparam C = 2;
localparam S10 = 3;
localparam S11 = 4;
localparam S20 = 5;
localparam S21 = 6;
localparam S22 = 7;

always @(posedge clk) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	case (state)
		A: begin
			if (s)
				next_state = B;
			else
				next_state = state;
		end
		
		B, C: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		
		S10: begin
			if (w)
				next_state = S21;
			else
				next_state = S20;
		end
		
		S11: begin
			if (w)
				next_state = S22;
			else
				next_state = S21;
		end
		
		S20: begin
			next_state = B;
		end
		
		S21: begin
			if (w)
				next_state = C;
			else
				next_state = B;
		end
		
		S22: begin
			if (w)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

always @(posedge clk) begin
	if (reset)
		z <= 0;
	else begin
		case (state)
			B, C, S10, S11: begin
				z <= 0;
			end
			
			S20, S21, S22: begin
				z <= 1;
			end
		endcase
	end
end

endmodule
