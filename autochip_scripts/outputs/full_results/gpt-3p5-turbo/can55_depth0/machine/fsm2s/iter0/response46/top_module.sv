module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg next_state;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b0;
	else begin
		case (state)
			2'b00: begin // state A
				if (j) begin
					next_state <= 2'b1; // transition to state B
				else
					next_state <= 2'b0; // stay in state A
			end
			2'b01: begin // state B
				if (k) begin
					next_state <= 2'b0; // transition to state A
				else
					next_state <= 2'b1; // stay in state B
			end
		endcase
	end
end

always @(posedge clk) begin
	state <= next_state;
end

assign out = (state == 2'b01);

endmodule
