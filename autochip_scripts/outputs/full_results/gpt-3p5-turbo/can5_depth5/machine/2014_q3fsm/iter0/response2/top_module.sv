module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define state enumeration
typedef enum logic [1:0] {
	A,
	B,
	C,
	S10,
	S11,
	S20,
	S21,
	S22
} fsm_state_t;

// Define state signal
reg [1:0] state, next_state;

// Define state transitions
always_ff @(posedge clk, posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Define state logic
always_comb begin
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
		default: next_state = state;
	endcase
end

// Define output logic
always_ff @(posedge clk, posedge reset) begin
	if (reset) begin
		z <= 0;
	end else begin
		if (state == C) begin
			z <= 1;
		end else begin
			z <= 0;
		end
	end
end

endmodule
