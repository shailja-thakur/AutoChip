module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Define current state and next state variables
reg [2:0] state_reg;
reg [2:0] state_next;

// Define state assignments based on inputs
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A; // Initialize the state to A
	end else begin
		state_reg <= state_next; // Update the state based on state_next
	end
end

// Define next state logic
always @* begin
	case(state_reg)
		A: begin
			if (s) begin
				state_next = B;
			end else begin
				state_next = A;
			end
		end
		B: begin
			if (w) begin
				if (state_reg == B) begin
					state_next = S11;
				end else begin
					state_next = S22;
				end
			end else begin
				if (state_reg == B) begin
					state_next = S10;
				end else begin
					state_next = S21;
				end
			end
		end
		C: begin
			if (w) begin
				if (state_reg == C) begin
					state_next = S11;
				end else begin
					state_next = S22;
				end
			end else begin
				if (state_reg == C) begin
					state_next = S10;
				end else begin
					state_next = S21;
				end
			end
		end
		S10: begin
			if (w) begin
				state_next = S21;
			end else begin
				state_next = S20;
			end
		end
		S11: begin
			if (w) begin
				state_next = S22;
			end else begin
				state_next = S21;
			end
		end
		S20: begin
			state_next = B;
		end
		S21: begin
			if (w) begin
				state_next = C;
			end else begin
				state_next = B;
			end
		end
		S22: begin
			if (w) begin
				state_next = B;
			end else begin
				state_next = C;
			end
		end
		default: begin
			state_next = A;
		end
	endcase
end

// Define output logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		z <= 0; // Reset the output to 0
	end else begin
		case(state_reg)
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
