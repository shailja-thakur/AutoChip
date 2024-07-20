module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

parameter A = 4'b0001;
parameter B = 4'b0011;
parameter C = 4'b0100;
parameter S10 = 4'b1001;
parameter S11 = 4'b1010;
parameter S20 = 4'b0111;
parameter S21 = 4'b1100;
parameter S22 = 4'b1101;

always @(posedge clk) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case(state)
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

always @(posedge clk) begin
	case(state)
		A: begin
			// Output logic for state A
			// ...
			z <= 0; // Set output to 0
		end
		B: begin
			// Output logic for state B
			// ...
			z <= 0; // Set output to 0
		end
		C: begin
			// Output logic for state C
			// ...
			z <= 0; // Set output to 0
		end
		S10: begin
			// Output logic for state S10
			// ...
			z <= 0; // Set output to 0
		end
		S11: begin
			// Output logic for state S11
			// ...
			z <= 0; // Set output to 0
		end
		S20: begin
			// Output logic for state S20
			// ...
			z <= 0; // Set output to 0
		end
		S21: begin
			// Output logic for state S21
			// ...
			z <= 0; // Set output to 0
		end
		S22: begin
			// Output logic for state S22
			// ...
			z <= 0; // Set output to 0
		end
	endcase
end

endmodule
