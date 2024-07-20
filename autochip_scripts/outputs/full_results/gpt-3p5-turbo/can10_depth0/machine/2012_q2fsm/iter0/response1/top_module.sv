module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		z <= 1'b0;
	end else begin
		case (state)
			3'b000: begin // State A
				if (w == 1'b0)
					state <= 3'b000; // Stay in A
				else
					state <= 3'b001; // Transition to B
			end
			3'b001: begin // State B
				if (w == 1'b0)
					state <= 3'b100; // Transition to D
				else
					state <= 3'b010; // Transition to C
			end
			3'b010: begin // State C
				if (w == 1'b0)
					state <= 3'b100; // Transition to D
				else
					state <= 3'b101; // Transition to E
			end
			3'b011: begin // State D
				if (w == 1'b0)
					state <= 3'b000; // Transition to A
				else
					state <= 3'b011; // Stay in D
			end
			3'b101: begin // State E
				if (w == 1'b0)
					state <= 3'b100; // Transition to D
				else
					state <= 3'b101; // Stay in E
			end
			3'b110: begin // State F
				if (w == 1'b0)
					state <= 3'b100; // Transition to D
				else
					state <= 3'b011; // Transition to C
			end
			default: begin
				state <= 3'b000;
			end
		endcase
	end
end

always @(state) begin
	if (state == 3'b101 || state == 3'b110)
		z <= 1'b1;
	else
		z <= 1'b0;
end

endmodule
