module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

parameter [3:0]
	A = 4'b0001,
	B = 4'b0010,
	C = 4'b0011,
	S10 = 4'b0100,
	S11 = 4'b0101,
	S20 = 4'b0110,
	S21 = 4'b0111,
	S22 = 4'b1000;

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Next state logic
always @(state, s, w) begin
	case (state)
		A: begin
			if (s) begin
				next_state = B;
			end else begin
				next_state = A;
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

// Output logic
always @(state) begin
	case (state)
		A: begin
			z = 0;
		end
			
		B: begin
			z = 0;
		end
			
		C: begin
			z = 0;
		end
			
		S10: begin
			z = 0;
		end
			
		S11: begin
			z = 0;
		end
			
		S20: begin
			z = 0;
		end
			
		S21: begin
			z = 0;
		end
			
		S22: begin
			z = 1;
		end
	endcase
end

endmodule
