module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
typedef enum logic [3:0] {
	A,
	B,
	C,
	S10,
	S11,
	S20,
	S21,
	S22
} state_type;

// Define current and next state variables
reg [3:0] curr_state;
reg [3:0] next_state;

// Define state transition conditions
always @(posedge clk or posedge reset) begin
	if (reset) begin
		curr_state <= A;
	end else begin
		curr_state <= next_state;
	end
end

// Define state transition logic
always @(curr_state, s, w) begin
	case (curr_state)
		A: begin
			if (s) begin
				next_state = B;
			end else begin
				next_state = curr_state;
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

// Define output logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		z <= 0;
	end else begin
		case (curr_state)
			A: begin
				z <= 0;
			end
			B: begin
				z <= 1;
			end
			C: begin
				z <= 1;
			end
			S10: begin
				z <= 0;
			end
			S11: begin
				z <= 0;
			end
			S20: begin
				z <= 1;
			end
			S21: begin
				z <= 1;
			end
			S22: begin
				z <= 0;
			end
		endcase
	end
end

endmodule
