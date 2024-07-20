module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
reg out_reg;

// State transition logic
always @(posedge clk, posedge areset) begin
	if (areset) begin
		state <= 2'b00; // Reset to state A
	end else begin
		state <= next_state;
	end
end

// Output logic
always @(state) begin
	case (state)
		2'b00: out_reg = 1'b0; // State A
		2'b01: out_reg = 1'b0; // State B
		2'b10: out_reg = 1'b0; // State C
		2'b11: out_reg = 1'b1; // State D
	endcase
end

// Next state and output assignment
always @(state, in) begin
	case (state)
		2'b00: begin // State A
			if (in) begin
				next_state = 2'b01; // Next state is B
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
		2'b01: begin // State B
			if (in) begin
				next_state = 2'b01; // Next state is B
			end else begin
				next_state = 2'b10; // Next state is C
			end
		end
		2'b10: begin // State C
			if (in) begin
				next_state = 2'b11; // Next state is D
			end else begin
				next_state = 2'b00; // Next state is A
			end
		end
		2'b11: begin // State D
			if (in) begin
				next_state = 2'b10; // Next state is C
			end else begin
				next_state = 2'b01; // Next state is B
			end
		end
	endcase
end

assign out = out_reg;

endmodule
