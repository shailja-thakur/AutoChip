module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define state enumeration
typedef enum logic [4:0] {
	A,
	B,
	C,
	S10,
	S11,
	S20,
	S21,
	S22
} state_type;

// Declare state and next_state registers
reg [4:0] state_reg;
reg [4:0] next_state_reg;

// Assign initial state
initial begin
	state_reg = A;
	next_state_reg = A;
end

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A;
		next_state_reg <= A;
	end else begin
		state_reg <= next_state_reg;
		case (state_reg)
			A: begin
				if (s)
					next_state_reg = B;
				else
					next_state_reg = A;
			end
			B: begin
				if (w)
					next_state_reg = S11;
				else
					next_state_reg = S10;
			end
			C: begin
				if (w)
					next_state_reg = S11;
				else
					next_state_reg = S10;
			end
			S10: begin
				if (w)
					next_state_reg = S21;
				else
					next_state_reg = S20;
			end
			S11: begin
				if (w)
					next_state_reg = S22;
				else
					next_state_reg = S21;
			end
			S20:
				next_state_reg = B;
			S21: begin
				if (w)
					next_state_reg = C;
				else
					next_state_reg = B;
			end
			S22: begin
				if (w)
					next_state_reg = B;
				else
					next_state_reg = C;
			end
		endcase
	end
end

// Output logic
always @(posedge clk) begin
	if (reset)
		z <= 0;
	else begin
		case (state_reg)
			S10, S11: begin
				z <= 1;
			end
			default: begin
				z <= 0;
			end
		endcase
	end
end

endmodule
