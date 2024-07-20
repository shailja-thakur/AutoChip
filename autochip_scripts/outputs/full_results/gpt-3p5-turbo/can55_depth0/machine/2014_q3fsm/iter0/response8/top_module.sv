module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter S10 = 2'b11;
parameter S11 = 2'b00;
parameter S20 = 2'b01;
parameter S21 = 2'b10;
parameter S22 = 2'b11;

// Define the current state and next state variables
reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @(state or s or w) begin
	case (state)
		A: begin
			if (s) begin
				next_state = B;
			end else begin
				next_state = state;
			end
		end
		B: begin
			if (w) begin
				next_state = S11;
			end else begin
				next_state = S10;
			end
		end
		C: begin
			if (w) begin
				next_state = S11;
			end else begin
				next_state = S10;
			end
		end
		S10: begin
			if (w) begin
				next_state = S21;
			end else begin
				next_state = S20;
			end
		end
		S11: begin
			if (w) begin
				next_state = S22;
			end else begin
				next_state = S21;
			end
		end
		S20: begin
			next_state = B;
		end
		S21: begin
			if (w) begin
				next_state = C;
			end else begin
				next_state = B;
			end
		end
		S22: begin
			if (w) begin
				next_state = B;
			end else begin
				next_state = C;
			end
		end
	endcase
end

always @(posedge clk) begin
	if (reset) begin
		z <= 0;
	end else begin
		case (state)
			S20, S21: begin
				z <= 1;
			end
			default: begin
				z <= 0;
			end
		endcase
	end
end

endmodule
