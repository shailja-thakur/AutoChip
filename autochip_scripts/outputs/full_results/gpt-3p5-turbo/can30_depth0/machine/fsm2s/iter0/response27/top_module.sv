module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
	end else begin
		state <= next_state;
	end
end

always @* begin
	case (state)
		2'b00: begin // State A
			if (j)
				next_state = 2'b01; // Transition to State B
			else
				next_state = 2'b00; // Stay in State A
		end
		2'b01: begin // State B
			if (k)
				next_state = 2'b00; // Transition to State A
			else
				next_state = 2'b01; // Stay in State B
		end
		default: next_state = 2'b00;
	endcase
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
