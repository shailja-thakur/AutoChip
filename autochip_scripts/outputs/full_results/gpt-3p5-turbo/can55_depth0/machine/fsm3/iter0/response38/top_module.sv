module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

// State machine logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // Reset state to A
	else
		state <= next_state; // Update state based on next_state
	end
end

// Combinational logic for determining next_state
always @(*) begin
	case(state)
		2'b00: begin
			if (in)
				next_state = 2'b01; // transition to B
			else
				next_state = 2'b00; // stay in A
		end
		2'b01: begin
			if (in)
				next_state = 2'b01; // stay in B
			else
				next_state = 2'b10; // transition to C
		end
		2'b10: begin
			if (in)
				next_state = 2'b11; // transition to D
			else
				next_state = 2'b00; // transition to A
		end
		2'b11: begin
			if (in)
				next_state = 2'b01; // transition to B
			else
				next_state = 2'b10; // transition to C
		end
	endcase
end

// Output logic
assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
