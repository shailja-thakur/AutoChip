module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Define states
typedef enum logic [1:0] {
	A = 2'b00,
	B = 2'b01,
	C = 2'b10,
	D = 2'b11
} state_type;

// Define signals
reg current_state, next_state;
assign out = (current_state == D);

// Define state transition logic
always @(posedge clk or posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

// Define next state logic
always @(current_state, in) begin
	case (current_state)
		A: begin
			if (in == 1)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (in == 1)
				next_state = B;
			else
				next_state = C;
		end
		C: begin
			if (in == 1)
				next_state = D;
			else
				next_state = A;
		end
		D: begin
			if (in == 1)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

endmodule
