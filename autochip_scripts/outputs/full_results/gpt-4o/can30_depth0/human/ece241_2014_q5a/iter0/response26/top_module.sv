module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

typedef enum reg [1:0] {S0, S1} state_type;
state_type state, next_state;
reg prev_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= S0;
	else
		state <= next_state;
end

always @(*) begin
	case (state)
		S0: begin
			if (x == 1)
				next_state = S1;
			else
				next_state = S0;
		end
		S1: begin
			next_state = S1;
		end
		default: next_state = S0;
	endcase
end

always @(posedge clk or posedge areset) begin
	if (areset)
		prev_state <= 0;
	else
		prev_state <= x;
end

always @(*) begin
	if (state == S0)
		z = ~x;   // Invert the bit
	else if (state == S1)
		z = x;    // Pass the bit as is

	if (areset)
		z = 0;
end

endmodule
