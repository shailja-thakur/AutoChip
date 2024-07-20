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
		state <= 2'b00; // Reset to state A
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		2'b00: begin // State A
			if (in == 1'b0) begin
				next_state = 2'b00; // Next state A
				out_reg = 1'b0;
			end else begin
				next_state = 2'b01; // Next state B
				out_reg = 1'b0;
			end
		end

		2'b01: begin // State B
			if (in == 1'b0) begin
				next_state = 2'b10; // Next state C
				out_reg = 1'b0;
			end else begin
				next_state = 2'b01; // Next state B
				out_reg = 1'b0;
			end
		end

		2'b10: begin // State C
			if (in == 1'b0) begin
				next_state = 2'b00; // Next state A
				out_reg = 1'b0;
			end else begin
				next_state = 2'b11; // Next state D
				out_reg = 1'b0;
			end
		end

		2'b11: begin // State D
			if (in == 1'b0) begin
				next_state = 2'b10; // Next state C
				out_reg = 1'b1;
			end else begin
				next_state = 2'b01; // Next state B
				out_reg = 1'b0;
			end
		end
	endcase
end

always @(posedge clk) begin
	out <= out_reg;
end

endmodule
