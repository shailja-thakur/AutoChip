module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b00; // Initialize state to A
	end else begin
		state <= next_state;
	end
end

always @(*) begin
	case (state)
		2'b00: begin // state A
			if (j) begin
				next_state = 2'b01; // Transition to state B
			end else begin
				next_state = 2'b00; // Remain in state A
			end
		end
		2'b01: begin // state B
			if (k) begin
				next_state = 2'b00; // Transition to state A
			end else begin
				next_state = 2'b01; // Remain in state B
			end
		end
	endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
