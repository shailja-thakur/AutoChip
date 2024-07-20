module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state, next_state;
reg out_reg;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00;     // Reset to state A
	end else begin
		state <= next_state;
	end
end

always @(state, in) begin
	case (state)
		2'b00: begin      // State A
			if (in) begin
				next_state = 2'b01;   // Next state B
			end else begin
				next_state = 2'b00;   // Next state A
			end
			out_reg = 1'b0;
		end
		2'b01: begin      // State B
			if (in) begin
				next_state = 2'b01;   // Next state B
			end else begin
				next_state = 2'b10;   // Next state C
			end
			out_reg = 1'b0;
		end
		2'b10: begin      // State C
			if (in) begin
				next_state = 2'b11;   // Next state D
			end else begin
				next_state = 2'b00;   // Next state A
			end
			out_reg = 1'b0;
		end
		2'b11: begin      // State D
			if (in) begin
				next_state = 2'b01;   // Next state B
			end else begin
				next_state = 2'b10;   // Next state C
			end
			out_reg = 1'b1;
		end
	endcase
end

assign out = out_reg;

endmodule
