module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Declare states as reg variables
reg [3:0] state, next_state;

// Define state values
parameter A = 4'b0000;
parameter B = 4'b0001;
parameter C = 4'b0010;
parameter S10 = 4'b0011;
parameter S11 = 4'b0100;
parameter S20 = 4'b0101;
parameter S21 = 4'b0110;
parameter S22 = 4'b0111;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(s or w or state) begin
	case (state)
		A: begin
			if (s)
				next_state = B;
			else
				next_state = state;
		end
		B: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		C: begin
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
		default: begin
			next_state = A;
		end
	endcase
end

always @(posedge clk) begin
	if (reset) begin
		z <= 0;
	end else begin
		case (state)
			A, B, C: begin
				z <= 0;
			end
			default: begin
				z <= 1;
			end
		endcase
	end
end

endmodule
